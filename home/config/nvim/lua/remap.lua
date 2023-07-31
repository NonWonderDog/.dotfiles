-- Lazy
vim.keymap.set('n', '<Leader>l', '<Cmd>Lazy<CR>')

-- Remove F1 help
vim.keymap.set({'n','i'},'<F1>','')

-- Netrw
vim.keymap.set('n', '<Leader>e', '<Cmd>Lexplore<CR>')

-- Move by screen lines instead of file lines, except in visual selection
vim.keymap.set({'n','x'}, 'j', "v:count == 0 ? 'gj' : 'j'", {expr=true, silent=true})
vim.keymap.set({'n','x'}, 'k', "v:count == 0 ? 'gk' : 'k'", {expr=true, silent=true})

-- Exit insert mode with jj or jk
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'jk', '<Esc>')

-- Move highlighted lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Maintain cursor position after join
vim.keymap.set('n', 'J', 'm`J``')

-- Recenter cursor on big moves
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
-- including quickfix moves
vim.keymap.set('n', '<C-k>', '<Cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<Cmd>cprev<CR>zz')
vim.keymap.set('n', '<C-k>', '<Cmd>lnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<Cmd>lprev<CR>zz')

-- Nondestructive delete/visual paste
vim.keymap.set({'n','v'}, '<Leader>d', '"_d')
vim.keymap.set('x',       '<Leader>p', 'P') -- see "v_P", map to "_dP if not supported

-- Clipboard yank
vim.keymap.set({'n','v'}, '<Leader>y', '"+y')
vim.keymap.set('n',       '<Leader>Y', '"+Y')

-- Replace all occurances
vim.keymap.set('n', '<Leader>*', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

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

