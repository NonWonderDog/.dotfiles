return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "vim", "vimdoc", "lua", "query",
                    "bash", "fish", "markdown_inline"
                },
                ignore_install = {},
                sync_install = false,
                auto_install = true,
                modules = {},
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
