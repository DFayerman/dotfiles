require("indent_blankline").setup({
  char = '⏐',
  -- space_char = ' ',
	space_char_blankline = ' ',
  filetype_exclude = { 'help', 'packer' },
  buftype_exclude = { 'terminal', 'nofile' },
  char_highlight = 'LineNr',
	show_current_context = true,
	use_treesitter = true,
})
