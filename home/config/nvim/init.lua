-----------------------
-- Environment setup --
-----------------------
vim.o.shell         = 'sh'
vim.o.updatetime    = 250
vim.o.timeoutlen    = 300  -- shorter 10 ms delay for terminal escape codes
vim.o.ttimeoutlen   = 10   -- shorter 10 ms delay for terminal escape codes
vim.o.title         = true -- update console title
vim.o.termguicolors = true -- 24-bit color
vim.fn.setenv("fish_greeting", "") -- no greeting in fish terminals

-- recognize SJIS
vim.go.fileencodings = 'ucs-bom,utf-8,sjis,default,latin1'

-- use ripgrep
if vim.fn.executable('rg') then
    vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
    vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end

-- use persistent undo
vim.o.undofile = true

-- WSL clipboard
if vim.fn.executable('clip.exe') then
    vim.cmd([[
        let g:clipboard = {
        \   'name': 'WslClipboard',
        \   'copy': {
        \      '+': 'clip.exe',
        \      '*': 'clip.exe',
        \    },
        \   'paste': {
        \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        \   },
        \   'cache_enabled': 0,
        \ }]])
end

-------------------
-- Configuration --
-------------------
require("config")
require("mappings")

-------------
-- Plugins --
-------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup('plugins')
