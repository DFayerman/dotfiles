require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"go",
		"html",
		"json",
		"tsx",
		"typescript",
		"javascript",
		"lua",
		"css",
		"rust",
		"python",
		"regex",
	},
	highlight = {
		enable = true,
		disable = { "html", "css" },
	},
	autopairs = { enable = true },
	autotag = { enable = true },
})
