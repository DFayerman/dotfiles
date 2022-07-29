vim.cmd [[packadd packer.nvim]]  -- required if opt = true for packer

-- bootstrap packer
-- local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--   packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
-- end

return require("packer").startup(function()
	use({ "wbthomason/packer.nvim", opt = true })

	-- speed up Neovim runtime
	use("lewis6991/impatient.nvim")

	-- statusline, tabline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = [[require('plugins.lualine-config')]],
	})

	-- fast comment, bracket text subjects and motions, helpful commands from
	-- a dwarven thurmalogical sage from Boston
	use("tpope/vim-surround")
	use("tpope/vim-commentary")
	use("tpope/vim-eunuch")

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = [[require('plugins.treesitter-config')]],
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		config = [[require('plugins.lsp-config')]],
	})

	-- custom LSP sources
	use("jose-elias-alvarez/null-ls.nvim")

	-- java
	-- use('mfussenegger/nvim-jdtls')

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
	use("onsails/lspkind-nvim")
	use({
		"lewis6991/gitsigns.nvim",
		config = [[require('plugins.gitsigns-config')]],
	})

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
	-- use({ 
	-- 	"mfussenegger/nvim-dap",
	-- 	config = [[require('plugins.dap-config')]],
	-- })

	-- floating terminal
	use('voldikss/vim-floaterm')

	use("nvim-lua/plenary.nvim")

	-- colorschemes
	use("sainnhe/gruvbox-material")
	-- use("EdenEast/nightfox.nvim")
end)
