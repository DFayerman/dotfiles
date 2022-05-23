-- required if opt = true for packer
vim.cmd [[packadd packer.nvim]]
-- bootstrap packer
-- local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--   packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
-- end

return require("packer").startup(function()
	use({ "wbthomason/packer.nvim", opt = true })

	-- speed up Neovim runtime
	use("lewis6991/impatient.nvim")

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = [[require('plugins.lualine-config')]],
	})

	-- fast comment, bracket text subjects and motions, helpful commands from
	-- Pope Daddy himself
	use("tpope/vim-surround")
	use("tpope/vim-commentary")
	use("tpope/vim-eunuch")
	use("tpope/vim-capslock")

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = [[require('plugins.treesitter-config')]],
	})

	-- CoC
	-- use({'neoclide/coc.nvim', branch = 'release'})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		config = [[require('plugins.lsp-config')]],
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")

	-- snippets
	use({
		"L3MON4D3/LuaSnip",
		requires = { "rafamadriz/friendly-snippets" },
		config = [[require('plugins.luasnips-config')]],
	})

	-- json schemastore (open source project) autocompletion
	use("b0o/schemastore.nvim")

	-- completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
		},
		config = [[require('plugins.cmp-config')]],
	})

	-- completion kinds and version control signs on side
	use({
		"lewis6991/gitsigns.nvim",
		config = [[require('plugins.gitsigns-config')]],
	})
	use("onsails/lspkind-nvim")

	-- autopair
	use({
		"windwp/nvim-autopairs",
		config = [[require('plugins.autopair-config')]],
		wants = "nvim-cmp",
	})

	use({
		"windwp/nvim-ts-autotag",
		config = [[require('plugins.ts-autotag-config')]],
	})

	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = [[require('plugins.tree-config')]],
	})

	-- highlight current word and other instances
	use("RRethy/vim-illuminate")
	use({
		"lukas-reineke/headlines.nvim",
		config = [[require('plugins.headlines-config')]],
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = [[require('plugins.indent-blankline-config')]],
	})

	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
		},
		config = [[require('plugins.telescope-config')]],
	})

	-- debugger
	use({ 
		"mfussenegger/nvim-dap",
		config = [[require('plugins.dap-config')]],
	})

	use("nvim-lua/plenary.nvim")
	use("sainnhe/gruvbox-material")
end)
