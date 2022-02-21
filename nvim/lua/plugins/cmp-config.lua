local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		keyword_length = 2,
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
	},
})
