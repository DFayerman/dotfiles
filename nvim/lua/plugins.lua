local Plug = vim.fn['plug#']

vim.call('plug#begin','~/.config/nvim/plugged')

-- LSP + completion + snippets + autopair
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'windwp/nvim-autopairs'

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', {
	['do'] = function()
		vim.call(':TSUpdate')
	end
})

-- airline (lualine)
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
--
-- colorscheme
Plug 'joshdick/onedark.vim'

-- fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

-- fast comment and brace-surround mappings
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

vim.call('plug#end')
