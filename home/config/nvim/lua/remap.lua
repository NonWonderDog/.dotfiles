local function map(mode, lhs, rhs, opts)
    if opts then opts = vim.tbl_extend('keep', opts, {silent=true}) end
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Remove F1 help
map({'n','o','v','i'},'<F1>','')

-- Remove select mode
map('n', 'gh', '')
map('n', 'gH', '')

-- plugin manager
map('n', '<Leader>L', '<Cmd>Lazy<CR>')

-- Terminal
map('n', '<Leader>t', "<Cmd>below split term://fish_greeting='' fish<CR>")

-- Line numbering
map('n', '<Leader>n', '<Cmd>set number! relativenumber!<CR>')

-- Netrw
if vim.fn.mapcheck('<Leader>e') == "" then
    map('n', '<Leader>e', '<Cmd>15Lexplore<CR>', {unique=true})
end

-- Change directory
map('n', '<Leader>cd', '<Cmd>cd %:p:h<CR>')
map('n', '<Leader>cl', '<Cmd>lcd %:p:h<CR>')

-- Move by screen lines instead of file lines, unless count is specified
map({'n','x'}, 'j', "v:count == 0 ? 'gj' : 'j'", {expr=true})
map({'n','x'}, 'k', "v:count == 0 ? 'gk' : 'k'", {expr=true})

-- Exit insert mode with jj or jk
map('i', 'jj', '<Esc>')
map('i', 'jk', '<Esc>')

-- Move and autoindent highlighted lines
-- map('v', 'J', ":m '>+1<CR>gv=gv")
-- map('v', 'K', ":m '<-2<CR>gv=gv")

-- Maintain cursor position after join
map('n', 'J', 'm`J``')

-- Quickfix navigation
map('n', '<C-k>',   '<Cmd>cnext<CR>')
map('n', '<C-j>',   '<Cmd>cprev<CR>')
map('n', '<C-S-K>', '<Cmd>lnext<CR>')
map('n', '<C-S-J>', '<Cmd>lprev<CR>')

-- Nondestructive delete
map({'n','v'}, '<Leader>d', '"_d')

-- Clipboard access
map({'n','v'}, '<Leader>y', '"+y')
map('n',       '<Leader>Y', '"+Y')
map({'n','v'}, '<Leader>p', '"+p')

-- Replace all occurances
map('n', '<Leader>*', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- navigate windows with Alt-hjkl
vim.o.winaltkeys = 'no'
map({'n','t'},'<A-h>',  '<Cmd>wincmd h<CR>')
map({'n','t'},'<A-j>',  '<Cmd>wincmd j<CR>')
map({'n','t'},'<A-k>',  '<Cmd>wincmd k<CR>')
map({'n','t'},'<A-l>',  '<Cmd>wincmd l<CR>')

-- toggle folds with leader space, recursively with modifier-space
map({'n','v'}, '<Leader><Space>',   'za')
map({'n','v'}, '<Leader><C-Space>', 'zA') -- gui only
map({'n','v'}, '<Leader><C-S-2>',   'zA') -- on terminal <C-Space> is <NUL> aka <C-@>
