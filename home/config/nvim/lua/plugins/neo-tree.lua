return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            -- sort_function = function (a,b)
            --       if a.type == b.type then
            --           return a.path > b.path
            --       else
            --           return a.type > b.type
            --       end
            --   end, -- this sorts files and directories descendantly
            default_component_configs = {
                -- container = {
                --     enable_character_fade = false
                -- },
                name = {
                    highlight_opened_files = true,
                },
                -- git_status = {
                --     symbols = {
                --         added     = "",
                --         modified  = "",
                --     }
                -- },
            },
            window = {
                position = "left",
                width = 30,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ["?"] = "show_help",
                    ["<space>"] = { "toggle_node" },
                    ["<2-LeftMouse>"] = "open",
                    ["<CR>"] = "open",
                    ["<Esc>"] = "cancel", -- close preview or floating neo-tree window
                    ["<C-l>"] = "refresh",
                    ["P"] = { "toggle_preview", config = { use_float = true } },
                    ["l"] = "focus_preview",
                    ["S"] = "open_split",
                    -- ["S"] = "split_with_window_picker",
                    ["s"] = "open_vsplit",
                    -- ["s"] = "vsplit_with_window_picker",
                    ["t"] = "open_tabnew",
                    -- ["<cr>"] = "open_drop",
                    -- ["t"] = "open_tab_drop",
                    -- ["w"] = "open_with_window_picker",
                    ["C"] = "close_node",
                    ["z"] = "close_all_nodes",
                    --["Z"] = "expand_all_nodes",
                    ["%"] = {
                        "add",
                        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                        config = {
                            show_path = "none", -- "none", "relative", "absolute"
                        }
                    },
                    ["d"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
                    ["D"] = "delete",
                    ["R"] = "rename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
                    ["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
                    ["e"] = "toggle_auto_expand_width",
                    ["q"] = "close_window",
                    ["<Leader>e"] = "close_window",
                    ["<"] = "prev_source",
                    [">"] = "next_source",
                }
            },
            filesystem = {
                window = {
                    mappings = {
                        ["H"] = "toggle_hidden",
                        ["/"] = "fuzzy_finder",
                        -- [""] = "fuzzy_finder_directory",
                        --["/"] = "filter_as_you_type", -- this was the default until v1.28
                        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                        -- ["D"] = "fuzzy_sorter_directory",
                        ["f"] = "filter_on_submit",
                        ["<C-x>"] = "clear_filter",
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["[g"] = "prev_git_modified",
                        ["]g"] = "next_git_modified",
                        ["<C-d>"] = "diff"
                    },
                    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                        ["<down>"] = "move_cursor_down",
                        ["<C-n>"] = "move_cursor_down",
                        ["<up>"] = "move_cursor_up",
                        ["<C-p>"] = "move_cursor_up",
                    },
                },
                commands = {
                    diff = function(state)
                        local log  = require 'neo-tree.log'
                        local utils = require 'neo-tree.utils'
                        local renderer = require 'neo-tree.ui.renderer'
                        local node = state.tree:get_node();
                        if node.type ~= "file" then
                            log.warn("The `diff` command can only be used on files")
                            return
                        end

                        state.clipboard = state.clipboard or {}
                        -- clear diff flag if it exists
                        local existing  = state.clipboard[node.id]
                        if existing and existing.action == "diff" then
                            state.clipboard[node.id] = nil
                            renderer.redraw(state)
                        else
                            -- diff with any other file marked 'diff'
                            for id, item in pairs(state.clipboard) do
                                if item.action == "diff" then
                                    state.commands["revert_preview"](state)
                                    -- open item
                                    local bufnr = item.node.extra and item.node.extra.bufnr
                                    log.warn(item.node.path)
                                    utils.open_file(state, item.node.path, 'edit', bufnr)
                                    local extra = item.node.extra or {}
                                    local pos = extra.position or extra.end_position
                                    if pos ~= nil then
                                        vim.api.nvim_win_set_cursor(0, { (pos[1] or 0) + 1, pos[2] or 0 })
                                        vim.api.nvim_win_call(0, function()
                                            vim.cmd("normal! zvzz") -- expand folds and center cursor
                                        end)
                                    end
                                    -- then diff with node
                                    local command = "vert diffs"
                                    if state.current_position == "left" then
                                        command = "rightbelow vert diffs"
                                    elseif state.current_position == "right" then
                                        command = "leftabove vert diffs"
                                    end
                                    local escaped_path = vim.fn.fnameescape(node.path)
                                    vim.cmd(command .. " " .. escaped_path)
                                    state.clipboard[id] = nil
                                    return
                                end
                            end
                            -- otherwise add diff flag
                            state.clipboard[node.id] = { action = "diff", node = node }
                            log.info("Marked " .. node.name .. " for diff")
                            renderer.redraw(state)
                        end
                    end
                },
                hijack_netrw_behavior = "disabled"
            },
            buffers = {
                group_empty_dirs = true,
                show_unloaded = true,
                window = {
                    mappings = {
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["bd"] = "buffer_delete",
                    }
                },
            },
            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["gA"] = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["ga"] = "git_add_file",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gd"] = "git_diff",
                        -- ["gg"] = "git_commit_and_push",
                    }
                },
                commands = {
                    git_diff = function(state)
                        local log  = require 'neo-tree.log'
                        local node = state.tree:get_node()
                        if node.type ~= "file" then
                            log.warn("The `git_diff` command can only be used on files")
                            return
                        end
                        state.commands["open"](state)
                        vim.cmd([[Gdiffsplit]]) -- vim-fugitive
                    end,
                }
            }
        })

        vim.keymap.set('n', '<Leader>e', '<Cmd>Neotree reveal_force_cwd<CR>', { desc = '[E]xplore file tree' })
        vim.keymap.set('n', '<Leader>E', '<Cmd>Neotree toggle show<CR>', { desc = 'toggle [E]xplore file tree' })
    end
}
