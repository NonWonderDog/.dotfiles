return {
    {
        'tpope/vim-fugitive',
        config = function()
            -- vim.keymap.set('n', '<Leader>g', '<Cmd>Git<CR>')
            vim.keymap.set('n', '<Leader>g', function()
                for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                    local buf = vim.api.nvim_win_get_buf(w)
                    local name = vim.api.nvim_buf_get_name(buf)
                    if name:match('^fugitive:') then
                        vim.api.nvim_win_close(w, false)
                        return
                    end
                end
                vim.cmd("Git")
            end)
        end
    }
}
