return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "c", "vim", "vimdoc", "lua", "query",
                    "bash", "fish", "markdown_inline",
                    "rust", "python", "doxygen"
                },
                ignore_install = {},
                sync_install = false,
                auto_install = true,
                modules = {},
                highlight = { enable = true },
                indent = { enable = true },
                disable = function(_, buf)
                    local max_filesize = 1024 * 1024 -- 1 MB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            })
        end,
    }
}
