require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"css",
		"go",
		"html",
		"http",
		"dockerfile",
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
