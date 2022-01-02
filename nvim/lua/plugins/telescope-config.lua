require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
		},
	},
	defaults = {
		mappings = {
			i = {
				["<Esc>"] = actions.close,
			},
		},
	},
})
