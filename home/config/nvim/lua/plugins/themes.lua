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
                        Folded = { fg = theme.ui.special, bg = theme.ui.bg },
                        ["@keyword.directive"] = { link = "PreProc" },
                        ["@constant.builtin"] = { link = "Constant" },
                        ["@comment.documentation"] = { fg = theme.diag.hint, italic = true },
                        ["@string.documentation"] = { fg = theme.diag.hint },
                    }
                end,
            })
            require("kanagawa").load("wave")
            vim.api.nvim_create_autocmd("TermOpen", {
                callback = function()
                    vim.cmd.setlocal('winhighlight=Normal:NormalDark')
                end
            })
        end
    },
}
