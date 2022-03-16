function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(
		mode,
		shortcut,
		command,
		{ noremap = true, silent = true }
	)
end

function nmap(shortcut, command)
	map("n", shortcut, command)
end

function imap(shortcut, command)
	map("i", shortcut, command)
end

function vmap(shortcut, command)
	map("v", shortcut, command)
end

function tmap(shortcut, command)
	map("t", shortcut, command)
end

-- basic
nmap("<C-s>", ":wa<CR>")
nmap("<C-c>", "<Esc>")
-- tab through buffers
nmap("<TAB>", ":bnext<CR>")
nmap("<S-TAB>", ":bprevious<CR>")
-- open terminal + jump to current file's directory
nmap(
	"<M-`>",
	':let $VIM_DIR=expand("%:p:h")<CR>:terminal<CR>acd $VIM_DIR<CR>clear<CR>'
)
-- fuzzy finder
nmap("<C-p>", ":Telescope find_files<CR>")
-- VSCode-style close file (overwrites viewport prefix)
-- TODO: close non-tab buffers on single tab open
vim.api.nvim_set_keymap(
	"n",
	"<M-w>",
	[[ len(getbufinfo({"buflisted":1})) == 1 ? ":wq<CR>" : &buftype ==# "terminal" || &buftype ==# "help" || &buftype ==# "nofile" ? ":bd!<CR>" : ":w<CR>:bd!<CR>" ]],
	{ noremap = true, silent = true, expr = true }
)
-- Neovim built-in terminal emulator mappings
tmap("<Esc>", "<C-\\><C-n>")
-- toggle Nvim-Tree
nmap("<Leader><TAB>", ":NvimTreeToggle<CR>")
-- move between splits
nmap("<C-l>", "<C-w>l")
imap("<C-l>", "<Esc><C-w>l")
nmap("<C-h>", "<C-w>h")
imap("<C-h>", "<Esc><C-w>h")
