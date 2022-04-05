-- set LEADER key here
vim.g.mapleader = " "

-- load impatient plugin first
pcall(require, "impatient")

-- ROOT CONFIG INIT
require("plugins")
require("settings")
require("keys")

-- below errors if not run last after plugins loaded
vim.cmd([[
	syntax on
	augroup packer_user_config
    autocmd!
    autocmd BufWritePost lua/plugins/init.lua source <afile> | PackerCompile
  augroup end
]])
