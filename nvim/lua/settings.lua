local opt = vim.opt

opt.encoding = "utf-8"
opt.shell = "/bin/zsh"
opt.background = "dark"
opt.termguicolors = true
opt.cc = "80"

vim.cmd([[
	filetype plugin indent on
	colorscheme gruvbox-material
]])

opt.guicursor = "n-v-c:block-Cursor"
opt.number = true
opt.relativenumber = true
opt.hidden = true
opt.shortmess:append("cA")
opt.showmode = false
opt.laststatus = 3
opt.winbar = "%=%m %f"

opt.completeopt = {'menuone', 'menu'}
opt.incsearch = true
opt.showmatch = true
opt.ignorecase = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftround = true
opt.shiftwidth = 2
opt.smarttab = true
opt.autoindent = true
opt.wrap = false

opt.mouse = "a"
opt.clipboard = "unnamedplus"

opt.cmdheight = 2
opt.updatetime = 150
opt.timeoutlen = 250

opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- disable built-in plugins
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

-- dynamic python3 host provider
local fileHandle = assert(io.popen("pyenv which python", "r"))
local commandOutput = string.gsub(assert(fileHandle:read("*a")), "\n", "")
fileHandle:close()
vim.g.python3_host_prog = commandOutput

-- enforce 80 col width in markdown files
vim.cmd([[  au BufRead,BufNewFile *.md setlocal textwidth=80  ]])
