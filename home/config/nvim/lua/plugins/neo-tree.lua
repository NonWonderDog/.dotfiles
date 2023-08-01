return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function ()
        -- If you want icons for diagnostic errors, you'll need to define them somewhere:
        vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
        vim.fn.sign_define("DiagnosticSignWarn",  {text = " ", texthl = "DiagnosticSignWarn"})
        vim.fn.sign_define("DiagnosticSignInfo",  {text = " ", texthl = "DiagnosticSignInfo"})
        vim.fn.sign_define("DiagnosticSignHint",  {text = "󰌵", texthl = "DiagnosticSignHint"})

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
                auto_expand_width = true,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ["<space>"] = {
                        "toggle_node",
                        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
                    },
                    ["<2-LeftMouse>"] = "open",
                    ["<cr>"] = "open",
                    ["<esc>"] = "cancel", -- close preview or floating neo-tree window
                    ["P"] = { "toggle_preview", config = { use_float = true } },
                    ["l"] = "focus_preview",
                    ["S"] = "open_split",
                    -- ["S"] = "split_with_window_picker",
                    ["s"] = "open_vsplit",
                    -- ["s"] = "vsplit_with_window_picker",
                    ["t"] = "open_tabnew",
                    -- ["<cr>"] = "open_drop",
                    -- ["t"] = "open_tab_drop",
                    ["w"] = "open_with_window_picker",
                    ["C"] = "close_node",
                    ["z"] = "close_all_nodes",
                    --["Z"] = "expand_all_nodes",
                    ["R"] = "refresh",
                    ["a"] = {
                        "add",
                        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                        config = {
                            show_path = "none", -- "none", "relative", "absolute"
                        }
                    },
                    ["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
                    ["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
                    ["e"] = "toggle_auto_expand_width",
                    ["q"] = "close_window",
                    ["?"] = "show_help",
                    ["<"] = "prev_source",
                    [">"] = "next_source",
                }
            },
            filesystem = {
                window = {
                    mappings = {
                        ["H"] = "toggle_hidden",
                        ["/"] = "fuzzy_finder",
                        ["D"] = "fuzzy_finder_directory",
                        --["/"] = "filter_as_you_type", -- this was the default until v1.28
                        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                        -- ["D"] = "fuzzy_sorter_directory",
                        ["f"] = "filter_on_submit",
                        ["<C-x>"] = "clear_filter",
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["[g"] = "prev_git_modified",
                        ["]g"] = "next_git_modified",
                    },
                    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                        ["<down>"] = "move_cursor_down",
                        ["<C-n>"] = "move_cursor_down",
                        ["<up>"] = "move_cursor_up",
                        ["<C-p>"] = "move_cursor_up",
                    },
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
                        -- ["gg"] = "git_commit_and_push",
                    }
                }
            }
        })

        vim.keymap.set('n', '<Leader>e', '<Cmd>Neotree reveal<CR>')
    end
}
