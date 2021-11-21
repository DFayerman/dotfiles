local opt = vim.opt

vim.cmd [[
	colorscheme onedark
	syntax on
	filetype plugin indent on
]]
opt.guicursor = 'i:block'
opt.cursorline = true
opt.number = true
opt.hidden = true
opt.shortmess:append "c"

opt.incsearch = true
opt.showmatch = true
opt.ignorecase = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smarttab = true
opt.autoindent = true
opt.wrap = false

opt.mouse = 'a'
opt.clipboard = 'unnamedplus'

opt.laststatus = 0
opt.cmdheight = 2
opt.updatetime = 150
opt.timeoutlen = 250

opt.backup = false
opt.writebackup = false
opt.swapfile = false

opt.background = 'dark'
opt.termguicolors = true

opt.completeopt = 'menuone,noselect'

vim.g.python3_host_prog = '/usr/bin/python3.8'