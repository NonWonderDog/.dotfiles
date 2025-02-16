-- spacebar leader
vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

-- sessions
vim.opt.sessionoptions = {
    'folds', 'help', 'sesdir', 'tabpages', 'terminal', 'winsize'
}

-- editing
vim.o.splitright     = true    -- vsplit to right
vim.o.equalalways    = false   -- don't resize on split
vim.o.virtualedit    = 'block' -- allow virtual editing in Visual block mode
vim.o.listchars      = 'tab:►─,eol:¬,trail:·,nbsp:⁃,precedes:←,extends:→'
vim.o.scrolloff      = 0
vim.o.sidescrolloff  = 8
vim.wo.signcolumn    = 'number'
vim.o.number         = true
vim.o.relativenumber = true
vim.opt.diffopt:append {'vertical'}
-- vim.o.winwidth       = 80 -- autoresize windows to keep minimum size
-- vim.o.winheight      = 24 -- autoresize windows to keep minimum size

-- search
vim.o.ignorecase = true
vim.o.smartcase  = true

-- fold
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevelstart = 99
vim.opt.foldopen:remove {'block'} -- don't open folds with { } motions

-- indent
vim.o.tabstop     = 8    -- tabs are 8 spaces for POSIX compatibility
vim.o.softtabstop = 8
vim.o.shiftwidth  = 4    -- but new indents are 4 spaces
vim.o.smarttab    = true -- tabs at start of line are indents
vim.o.expandtab   = true -- and all of them are spaces anyway

-- line wrap
vim.o.wrap        = false
vim.o.linebreak   = true
vim.o.showbreak   = '..'
vim.o.breakindent = true

-- text formatting
vim.o.colorcolumn = '80'
vim.o.textwidth   = 79
vim.opt.formatoptions:remove('t')   -- why is forced autoformat on
vim.opt.formatoptions:append('wal') -- format paragraphs by trailing space
vim.opt.formatoptions:append('1') -- better line wrap

vim.opt.formatoptions:append('n') -- recognize numbered lists
vim.opt.formatlistpat:append([[\|^\s*[*-][\t ]\s*]]) -- and bulleted lists

vim.o.joinspaces = true -- join sentences with two spaces
vim.opt.cpoptions:append('J') -- move by sentences requires two periods
vim.opt.formatoptions:append('p') -- don't break at single space after period

-- code formatting
vim.opt.cinoptions:append {
	':0',  -- don't indent case labels
	'g0',  -- don't indent scope declarations
	'N-s', -- don't indent namespace members
}

-- terminal autocmds
local termcmds = vim.api.nvim_create_augroup("MyTerminal", {})
vim.api.nvim_create_autocmd("TermOpen", {
    group = termcmds,
    callback = function()
	vim.wo.signcolumn = "no"
	vim.wo.number = false
	vim.wo.relativenumber = false
    end
})
vim.api.nvim_create_autocmd("TermClose", {
    group = termcmds,
    callback = function(ev)
	if tonumber(vim.v.event['status']) == 0 then
	    vim.cmd.bdelete { ev.buf, bang = true }
	end
    end
})

-- netrw
vim.g.netrw_banner = 0
