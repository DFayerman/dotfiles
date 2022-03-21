require("lualine").setup({
	options = {
		icons_enabled = true,
		globalstatus = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = false,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			"diff",
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
			},
		},
		lualine_c = {
			{
				"filetype",
				colored = true,
			},
		},
		lualine_x = { "encoding", "fileformat" },
		-- lualine_y = {'progress'},
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = {
			{
				"buffers",
				mode = 2,
				show_filename_only = false,
			},
		},
	},
	-- these don't really do anything AFAIK
	extensions = {"nvim-tree","fugitive"},
})
