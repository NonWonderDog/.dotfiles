return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- package manager
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',

        -- status updates
        {
            'j-hui/fidget.nvim',
            tag = 'legacy',
            event = 'LspAttach',
            config = true
        },

        -- Neovim Lua
        'folke/neodev.nvim',

        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',

        -- Snippets
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        local on_attach = function(_, bufnr)
            local nmap = function(keys,func,desc)
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

            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
            -- nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')

            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('<Leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<Leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            nmap('<Leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<Leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<Leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')

            nmap('<Leader>d', vim.diagnostic.open_float, 'Open floating [D]iagnostic message')
            nmap('<Leader>e', vim.diagnostic.setloclist, 'Open diagnostics list')
            nmap('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
            nmap(']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')

            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        local servers = {
            -- clangd = {},
            -- rust_analyzer = {},
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
        -- require('luasnip.loaders.from_vscode').lazy_load()
        -- require('luasnip.loaders.from_snipmate').lazy_load()
        luasnip.config.setup()

        local cmp_config = {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<C-S-2>'] = cmp.mapping.complete {},
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i','s' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i','s' }),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            },
        }
        cmp.setup(cmp_config)
    end
}
