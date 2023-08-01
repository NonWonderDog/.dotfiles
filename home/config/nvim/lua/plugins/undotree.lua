return {
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<Leader>u', '<Cmd>UndotreeToggle<CR>')
            vim.g.undotree_SetFocusWhenToggle = true
            vim.g.undotree_ShortIndicators    = true
        end
    }
}
