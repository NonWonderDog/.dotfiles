-- spacebar leader
vim.g.mapleader = " "

-- sessions
vim.opt.sessionoptions = {
    "folds", "help", "sesdir", "tabpages", "terminal", "winsize"
}

-- editing
vim.o.splitright  = true    -- vsplit to right
vim.o.equalalways = false   -- don't resize on split
vim.o.virtualedit = 'block' -- allow virtual editing in Visual block mode
vim.o.listchars   = 'tab:►─,eol:¬,trail:·,nbsp:⁃,precedes:←,extends:→'
vim.o.scrolloff   = 8
vim.opt.diffopt:append {'vertical'}

-- search
vim.o.ignorecase = true
vim.o.smartcase  = true

-- fold
vim.o.foldmethod = 'syntax'
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
vim.o.textwidth   = 79
vim.opt.formatoptions:append('w','a')     -- format paragraphs by trailing space
vim.opt.formatoptions:append('1','m','M') -- better line wrap

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

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 30
vim.g.netrw_keepdir = 0 -- make file operations always work