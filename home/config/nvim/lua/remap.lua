local function noremap(mode, lhs, rhs, opts)
    if opts then opts = vim.tbl_extend('keep', opts, {noremap=true, silent=true}) end
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Remove F1 help
noremap({'n','o','v','i'},'<F1>','')

-- plugin manager
noremap('n', '<Leader>l', '<Cmd>Lazy<CR>')

-- Netrw
noremap('n', '<Leader>e', '<Cmd>15Lexplore<CR>')

-- Change directory
noremap('n', '<Leader>cd', '<Cmd>cd %:p:h<CR>')
noremap('n', '<Leader>cl', '<Cmd>lcd %:p:h<CR>')

-- Move by screen lines instead of file lines, unless count is specified
noremap({'n','x'}, 'j', "v:count == 0 ? 'gj' : 'j'", {expr=true})
noremap({'n','x'}, 'k', "v:count == 0 ? 'gk' : 'k'", {expr=true})

-- Exit insert mode with jj or jk
noremap('i', 'jj', '<Esc>')
noremap('i', 'jk', '<Esc>')

-- Move and autoindent highlighted lines
noremap('v', 'J', ":m '>+1<CR>gv=gv")
noremap('v', 'K', ":m '<-2<CR>gv=gv")

-- Maintain cursor position after join
noremap('n', 'J', 'm`J``')

-- Quickfix navigation
noremap('n', '<C-k>',   '<Cmd>cnext<CR>')
noremap('n', '<C-j>',   '<Cmd>cprev<CR>')
noremap('n', '<C-S-K>', '<Cmd>lnext<CR>')
noremap('n', '<C-S-J>', '<Cmd>lprev<CR>')

-- Nondestructive delete
noremap({'n','v'}, '<Leader>d', '"_d')

-- Clipboard access
noremap({'n','v'}, '<Leader>y', '"+y')
noremap('n',       '<Leader>Y', '"+Y')
noremap({'n','v'}, '<Leader>p', '"+p')

-- Replace all occurances
noremap('n', '<Leader>*', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- navigate windows with Alt-hjkl
vim.o.winaltkeys = 'no'
noremap('n','<Esc>h', '<Cmd>wincmd h<CR>')
noremap('n','<Esc>j', '<Cmd>wincmd j<CR>')
noremap('n','<Esc>k', '<Cmd>wincmd k<CR>')
noremap('n','<Esc>l', '<Cmd>wincmd l<CR>')
noremap('n','<A-h>',  '<Cmd>wincmd h<CR>')
noremap('n','<A-j>',  '<Cmd>wincmd j<CR>')
noremap('n','<A-k>',  '<Cmd>wincmd k<CR>')
noremap('n','<A-l>',  '<Cmd>wincmd l<CR>')
noremap('t','<Esc>h', '<C-w>h')
noremap('t','<Esc>j', '<C-w>j')
noremap('t','<Esc>k', '<C-w>k')
noremap('t','<Esc>l', '<C-w>l')
noremap('t','<A-h>',  '<C-w>h')
noremap('t','<A-j>',  '<C-w>j')
noremap('t','<A-k>',  '<C-w>k')
noremap('t','<A-l>',  '<C-w>l')

-- toggle folds with leader space, recursively with modifier-space
noremap({'n','v'}, '<Leader><Space>',   'za')
noremap({'n','v'}, '<Leader><C-Space>', 'zA') -- gui only
noremap({'n','v'}, '<Leader><C-S-2>',   'zA') -- on terminal <C-Space> is <NUL> aka <C-@>
