local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.setup({
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
		}),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = "menuone,noinsert",
		keyword_length = 1,
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({
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
	sources = cmp.config.sources({
		{ name = "nvim_lsp" , priority = 9999},
		{ name = "luasnip", priority = 9998 },
	}, {
		{ name = "path" , priority=9997},
		{ name = "nvim_lua" },
		-- { name = "buffer" },
	})
})
