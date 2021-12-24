require('nvim-treesitter.configs').setup {
	highlight = {
    enable = true,
		disable = {'html'}
  },
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
		"regex"
	},
	autopairs = {enable = true},
	autotag = {enable = true},
}
