require('nvim-treesitter.configs').setup {
	highlight = {
    enable = true,
		disable = {'html'}
  },
	ensure_installed = {
		"go",
		"html",
		"json"
	}
}
