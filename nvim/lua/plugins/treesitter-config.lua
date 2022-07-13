require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"comment",
		"css",
		"go",
		"html",
		"http",
		"dockerfile",
		"java",
		"javascript",
		"json",
		"lua",
		"markdown",
		"python",
		"regex",
		"rust",
		"tsx",
		"typescript",
		"vim",
	},
	highlight = {
		enable = true,
		disable = { "html", "css" },
	},
	autopairs = { enable = true },
	-- don't need to enable below with nvim-ts-autotag setup
	-- autotag = { enable = true },
})
