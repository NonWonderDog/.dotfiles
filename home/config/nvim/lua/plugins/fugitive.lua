return {
    {
        'tpope/vim-fugitive',
        config = function ()
            vim.keymap.set('n', '<Leader>g', vim.cmd.Git)
        end
    }
}
