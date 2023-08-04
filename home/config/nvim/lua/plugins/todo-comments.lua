return {
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local plug = require('todo-comments')
            vim.keymap.set("n", "]t", function()
                plug.jump_next()
            end, { desc = "Next todo comment" })

            vim.keymap.set("n", "[t", function()
                plug.jump_prev()
            end, { desc = "Previous todo comment" })
            plug.setup({
                -- highlight = {
                --     pattern = [[.*<(KEYWORDS)\s*]], -- don't require ':'
                --     keyword = 'bg', -- don't highlight space after pattern
                -- },
                -- search = {
                --     pattern = [[\b(KEYWORDS)\b]], -- don't require ':'
                -- },
            })
        end
    },
}
