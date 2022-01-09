local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_nodep

ls.config.set_config({
	updateevents = "TextChanged,TextChangedI",
})

ls.snippets = {
	go = {
		s("iferr", {
			t({ "if err != nil {", "\t" }),
			i(0),
			t({ "", "}" }),
		}),
		s("fmain", {
			t({ "func main() {", "\t" }),
			i(0),
			t({ "", "}" }),
		}),
	},
}

require("luasnip/loaders/from_vscode").lazy_load()
