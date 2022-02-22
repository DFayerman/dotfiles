require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<Esc>"] = require('telescope.actions').close,
			},
		},
	},
	pickers = {
		find_files = {
			theme = "ivy",
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
		},
	},
})
