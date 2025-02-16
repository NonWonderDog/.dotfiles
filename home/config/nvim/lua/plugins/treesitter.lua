return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "vim", "vimdoc", "lua", "query",
                "bash", "fish", "markdown_inline",
                "rust",
            },
            ignore_install = {},
            sync_install = false,
            auto_install = true,
            modules = {},
            highlight = { enable = true },
            indent = { enable = true },
        }
    }
}
