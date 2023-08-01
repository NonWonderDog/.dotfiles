return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<C-p>',      builtin.git_files,   { desc = 'Git Files' })
            vim.keymap.set('n', '<Leader>gf', builtin.git_files,   { desc = '[G]it [F]iles' })
            vim.keymap.set('n', '<Leader>ff', builtin.find_files,  { desc = '[F]ind [F]iles' })
            vim.keymap.set('n', '<Leader>fr', builtin.oldfiles,    { desc = '[F]ind [R]ecent file' })
            vim.keymap.set('n', '<Leader>fg', builtin.live_grep,   { desc = '[F]ind by [G]rep' })
            vim.keymap.set('n', '<Leader>fb', builtin.buffers,     { desc = '[F]ind [B]uffers' })
            vim.keymap.set('n', '<Leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
            vim.keymap.set('n', '<Leader>f*', builtin.grep_string, { desc = '[F]ind current word' })
            vim.keymap.set('n', '<Leader>fh', builtin.help_tags,   { desc = '[F]ind in [H]elp' })
            vim.keymap.set('n', '<Leader>fd', builtin.diagnostics, { desc = '[F]ind in [D]iagnostics' })
            vim.keymap.set('n', '<Leader>fG', function()
                builtin.grep_string({ search = vim.fn.input("grep ") })
            end, { desc = '[F]ind by [G]rep string' })
            vim.keymap.set('n', '<Leader>/', function()
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzy search in current buffer' })
        end
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        build = 'make',
        cond = function()
            return vim.fn.executable('make') == 1
        end,
        config = function()
            pcall(require('telescope').load_extension('fzf'))
        end,
    }
}
