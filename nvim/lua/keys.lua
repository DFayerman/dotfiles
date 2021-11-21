function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end


nmap('<C-s>',':wa<CR>')
nmap('<C-c>','<Esc>')
-- tab through buffers
nmap('<TAB>',':bnext<CR>')
nmap('<S-TAB>',':bprevious<CR>')
-- fuzzy finder
nmap('<C-p>',':Telescope find_files<CR>')