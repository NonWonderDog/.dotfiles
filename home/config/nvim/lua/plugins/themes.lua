return {
    {
        'yorik1984/newpaper.nvim',
        lazy = false,
        priority = 1000
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                    }
                end,
            })
            require("kanagawa").load("wave")
            vim.api.nvim_create_autocmd("TermOpen", {
                callback = function()
                    vim.cmd.setlocal('winhighlight=Normal:NormalDark')
                    vim.wo.signcolumn = "no"
                end
            })
        end
    },
    {
        'NvChad/nvim-colorizer.lua',
        config = true,
    },
}
