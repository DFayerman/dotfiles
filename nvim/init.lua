global = {}
-- ROOT CONFIG INIT
require('plugins')
require('settings')
require('keys')


-- below errors if not run last after plugins loaded
vim.cmd [[
	syntax on
	autocmd vimenter * ++nested colorscheme gruvbox
	augroup packer_user_config
    autocmd!
    autocmd BufWritePost lua/plugins/init.lua source <afile> | PackerCompile
  augroup end
]]
