return {
{ 
	"catppuccin/nvim", 
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme catppuccin]])
	end,
},
{
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate"
},
{
	'nvim-telescope/telescope.nvim',
	tag = '0.1.1',
	dependencies = { 'nvim-lua/plenary.nvim' }
},
{
	"tpope/vim-surround"
},
{
	"tpope/vim-commentary"
},
{
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v1.x',
	dependencies = {
	-- LSP Support
	{'neovim/nvim-lspconfig'},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},

	-- Autocompletion
	{'hrsh7th/nvim-cmp'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/cmp-path'},
	{'saadparwaiz1/cmp_luasnip'},
	{'hrsh7th/cmp-nvim-lua'},

	-- Snippets
	{'L3MON4D3/LuaSnip'},
	{'rafamadriz/friendly-snippets'},
}
}
}
