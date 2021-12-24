vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
	use { "wbthomason/packer.nvim", opt = true }
	
-- fast comment and brace-surround mappings
	use('tpope/vim-surround')
	use('tpope/vim-commentary')

-- LSP
	use {
		"neovim/nvim-lspconfig",
		config = [[require('plugins.lsp-config')]],
	}
	use('jose-elias-alvarez/null-ls.nvim')
	use('jose-elias-alvarez/nvim-lsp-ts-utils')

-- snippets
	use { 
		'L3MON4D3/LuaSnip',
		config = [[require('plugins.luasnips-config') ]],
	}

-- completion
	use {
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			'saadparwaiz1/cmp_luasnip',
		},
		config = [[require('plugins.cmp-config')]],
	}

-- autopair
	use {
		'windwp/nvim-autopairs',
		config = [[require('plugins.autopair-config')]],
	}

-- Treesitter
	use { 
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = [[require('plugins.treesitter-config')]],
	}

-- markdown preview
	use {
		'iamcco/markdown-preview.nvim', 
		run = 'cd app && yarn install', 
		cmd = 'MarkdownPreview'
	}

-- airline (lualine)
	use {
		'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config = [[require('plugins.lualine-config')]],
	}

-- colorscheme
	use('morhetz/gruvbox')

-- fuzzy finder
	use('nvim-telescope/telescope.nvim')
	use('nvim-lua/plenary.nvim') -- loaded on its own because it may be used by other plugins

-- speed up Neovim runtime
	use('nathom/filetype.nvim')

end)



