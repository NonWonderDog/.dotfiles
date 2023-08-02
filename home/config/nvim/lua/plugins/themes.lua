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
            require("kanagawa").load("wave")
        end
    },
    {
        'NvChad/nvim-colorizer.lua',
        config = true,
    },
}
