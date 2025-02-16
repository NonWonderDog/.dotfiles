return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- package manager
        { 'williamboman/mason.nvim', opts = {} },
        'williamboman/mason-lspconfig.nvim',

        -- status updates
        {
            'j-hui/fidget.nvim',
            tag = 'legacy',
            event = 'LspAttach',
            opts = {}
        },

        -- Neovim Lua
        'folke/neodev.nvim',

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            event = { "InsertEnter", "CmdlineEnter" },
        },
        'hrsh7th/cmp-nvim-lsp',

        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('<F2>', vim.lsp.buf.rename, 'Rename')
            nmap('<F3>', function() vim.lsp.buf.format() end, 'Format current buffer with LSP')
            nmap('<F4>', vim.lsp.buf.code_action, 'Code Action')

            nmap('K', vim.lsp.buf.hover, 'Hover documentation')
            nmap('<Leader>k', vim.lsp.buf.signature_help, 'Signature documentation')

            -- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            -- nmap('gD', vim.lsp.buf.type_definition, 'Goto type [D]efinition')
            -- nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            -- nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
            nmap('gh', vim.lsp.buf.declaration, '[G]oto declaration (e.g in [H]eader)')

            local telescope = require('telescope.builtin')
            nmap('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
            nmap('gD', telescope.lsp_type_definitions, '[G]oto type [D]efinition')
            nmap('gi', telescope.lsp_implementations, '[G]oto [I]mplementation')
            nmap('gr', telescope.lsp_references, '[G]oto [R]eferences')
            nmap('<Leader>s', telescope.lsp_document_symbols, 'Document [S]ymbols')
            nmap('<Leader>S', telescope.lsp_dynamic_workspace_symbols, 'Workspace [S]ymbols')

            nmap('<Leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<Leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<Leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')

            nmap('<Leader>d', vim.diagnostic.open_float, 'Open floating [D]iagnostic message')
            nmap('<Leader>D', vim.diagnostic.setloclist, 'Open diagnostics list')
            nmap('[d', function() vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.INFO } }); end,
                'Go to previous diagnostic message')
            nmap(']d', function() vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.INFO } }); end,
                'Go to next diagnostic message')

            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        local servers = {
            -- clangd = {},
            rust_analyzer = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy",
                    },
                    rustfmt = {
                        extraArgs = { "+nightly" },
                    },
                },
                rustfmt = {
                    rangeFormatting = { enable = true },
                },
            },
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        }

        require('neodev').setup()

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        local mason_lspconfig = require 'mason-lspconfig'
        mason_lspconfig.setup {
            automatic_installation = true,
            ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                }
            end
        }

        local cmp = require 'cmp'
        local luasnip = require 'luasnip'

        -- load VS Code or SnipMate snippets from plugins
        require('luasnip.loaders.from_vscode').lazy_load()
        -- require('luasnip.loaders.from_snipmate').lazy_load()
        luasnip.config.setup()

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
        end

        local t = function(str)
            return vim.api.nvim_replace_termcodes(str, true, true, true)
        end

        local cmp_config = {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ['<Esc>'] = cmp.mapping.abort(),
                ['<C-n>'] = cmp.mapping({ -- next when menu visible, else <C-n>
                    c = function()
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                        end
                    end,
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end
                }),
                ['<C-p>'] = cmp.mapping({ -- previous when menu visible, else <C-n>
                    c = function()
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                        end
                    end,
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end
                }),
                ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
                ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-e>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if not entry then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        end
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<C-S-2>'] = cmp.mapping.complete {}, -- aka NUL aka C-Space
                ["<CR>"] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                }),
                ["<Tab>"] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end,
                    s = function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end
                }),
                ["<S-Tab>"] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end,
                    s = function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end
                }),
            },
            experimental = {
                ghost_text = true
            },
            sources = {
                {
                    name = 'nvim_lsp',
                    entry_filter = function(entry, _)
                        -- don't suggest random words from the buffer
                        return entry:get_kind() ~= require("cmp").lsp.CompletionItemKind.Text
                    end,
                },
                { name = 'luasnip' },
            },
            enabled = function()
                -- disable completion in comments
                local context = require 'cmp.config.context'
                -- keep command mode completion enabled when cursor is in a comment
                if vim.api.nvim_get_mode().mode == 'c' then
                    return true
                else
                    return not context.in_treesitter_capture("comment")
                        and not context.in_syntax_group("Comment")
                end
            end,
            formatting = {
                format = require("nvim-highlight-colors").format
            }
        }
        cmp.setup(cmp_config)
    end
}
