vim.g.mapleader = " "

-- Exit insert mode with jj or jk
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'jk', '<Esc>')

-- Move by screen lines instead of file lines, except in visual selection
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", {expr=true, silent=true})
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", {expr=true, silent=true})

-- Remove F1 help
vim.keymap.set({'n','i'},'<F1>','')

-- navigate windows with Alt-hjkl
vim.o.winaltkeys = 'no'
vim.keymap.set('n','<Esc>h', '<Cmd>wincmd h<CR>', {silent=true})
vim.keymap.set('n','<Esc>j', '<Cmd>wincmd j<CR>', {silent=true})
vim.keymap.set('n','<Esc>k', '<Cmd>wincmd k<CR>', {silent=true})
vim.keymap.set('n','<Esc>l', '<Cmd>wincmd l<CR>', {silent=true})
vim.keymap.set('n','<A-h>',  '<Cmd>wincmd h<CR>', {silent=true})
vim.keymap.set('n','<A-j>',  '<Cmd>wincmd j<CR>', {silent=true})
vim.keymap.set('n','<A-k>',  '<Cmd>wincmd k<CR>', {silent=true})
vim.keymap.set('n','<A-l>',  '<Cmd>wincmd l<CR>', {silent=true})
vim.keymap.set('t','<Esc>h', '<C-w>h', {silent=true})
vim.keymap.set('t','<Esc>j', '<C-w>j', {silent=true})
vim.keymap.set('t','<Esc>k', '<C-w>k', {silent=true})
vim.keymap.set('t','<Esc>l', '<C-w>l', {silent=true})
vim.keymap.set('t','<A-h>',  '<C-w>h', {silent=true})
vim.keymap.set('t','<A-j>',  '<C-w>j', {silent=true})
vim.keymap.set('t','<A-k>',  '<C-w>k', {silent=true})
vim.keymap.set('t','<A-l>',  '<C-w>l', {silent=true})

-- toggle folds with leader space
vim.keymap.set({'n','v'}, '<Leader><Space>', 'za')

