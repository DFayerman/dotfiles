vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
	use({ "wbthomason/packer.nvim", opt = true })

	-- speed up Neovim runtime
	use("lewis6991/impatient.nvim")

	use({ "kyazdani42/nvim-web-devicons" })

	-- statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		event = "VimEnter",
		config = [[require('plugins.lualine-config')]],
	})

	-- fast comment, bracket text subjects and motions,
	-- helpful commands for file system + Git from Pope Daddy himself
	use("tpope/vim-surround")
	use("tpope/vim-commentary")
	use("tpope/vim-eunuch")
	-- use("tpope/vim-fugitive")

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
	use("jose-elias-alvarez/null-ls.nvim")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")

	-- snippets
	use({
		"L3MON4D3/LuaSnip",
		config = [[require('plugins.luasnips-config')]],
	})

	-- completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
		},
		config = [[require('plugins.cmp-config')]],
	})

	use({
		"lewis6991/gitsigns.nvim",
		config = [[require('plugins.gitsigns-config')]],
	})

	use("onsails/lspkind-nvim")

	-- json schemastore (open source project) autocompletion
	use("b0o/schemastore.nvim")

	-- autopair
	use({
		"windwp/nvim-autopairs",
		-- after = 'nvim-cmp',
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
	-- use("RRethy/vim-illuminate")

	use({
		"lukas-reineke/headlines.nvim",
		config = [[require('plugins.headlines-config')]],
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		config = [[require('plugins.indent-blankline-config')]],
	})

	-- markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		opt = true,
		ft = { "markdown" },
		config = "vim.cmd[[doautocmd BufEnter]]",
		run = "cd app && yarn install",
		cmd = "MarkdownPreview",
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

	use("nvim-lua/plenary.nvim")

	-- smooth scroll
	use({
		"karb94/neoscroll.nvim",
		config = [[require('plugins.neoscroll-config')]],
	})

	-- colorscheme
	use("sainnhe/gruvbox-material")
end)
