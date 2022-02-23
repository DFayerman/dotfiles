local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local nvim_cmp = require("cmp_nvim_lsp")
local null_ls = require("null-ls")
local ts_utils = require("nvim-lsp-ts-utils")
local b = null_ls.builtins

-- credit to https://github.com/jose-elias-alvarez for inspiration

local border_opts = {
	border = "rounded",
	focusable = false,
	scope = "line",
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	virtual_text = {
		source = "if_many",
		prefix = "●",
	},
	float = {
		border = "rounded",
		focusable = false,
		source = "always",
	},
	signs = true,
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover,
	border_opts
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
	vim.lsp.handlers.signature_help,
	border_opts
)

-- remap helper
local bufmap = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		mode,
		lhs,
		rhs,
		opts or { silent = true }
	)
end

local preferred_formatting_clients = { "eslint_d", "eslint" }
local fallback_formatting_client = "null-ls"
local formatting = function(bufnr)
	bufnr = tonumber(bufnr) or vim.api.nvim_get_current_buf()
	local selected_client
	for _, client in ipairs(vim.lsp.buf_get_clients(bufnr)) do
		if vim.tbl_contains(preferred_formatting_clients, client.name) then
			selected_client = client
			break
		end
		if client.name == fallback_formatting_client then
			selected_client = client
		end
	end
	if not selected_client then
		return
	end
	local params = vim.lsp.util.make_formatting_params()
	selected_client.request(
		"textDocument/formatting",
		params,
		function(err, res)
			if err then
				local err_msg = type(err) == "string" and err or err.message
				vim.notify(
					"global.lsp.formatting: " .. err_msg,
					vim.log.levels.WARN
				)
				return
			end
			if
				not vim.api.nvim_buf_is_loaded(bufnr)
				or vim.api.nvim_buf_get_option(bufnr, "modified")
			then
				return
			end
			if res then
				vim.lsp.util.apply_text_edits(
					res,
					bufnr,
					selected_client.offset_encoding or "utf-16"
				)
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("silent noautocmd update")
				end)
			end
		end,
		bufnr
	)
end

-- set global options, not necessarily needed
global.lsp = {
	border_opts = border_opts,
	formatting = formatting,
}

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = nvim_cmp.update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- custom on_attach (mappings)
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	bufmap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	bufmap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	bufmap(bufnr, "n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	bufmap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	bufmap(
		bufnr,
		"n",
		"<Leader>f",
		"<cmd>lua vim.lsp.buf.formatting()<CR>",
		opts
	)
	bufmap(
		bufnr,
		"n",
		"<C-x>",
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
		opts
	)
	bufmap(
		bufnr,
		"i",
		"<C-x>",
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
		opts
	)
	bufmap(
		bufnr,
		"n",
		"<Leader>a",
		"<cmd>lua vim.diagnostic.open_float(nil,global.lsp.border_opts)<CR>",
		opts
	)

	if client.supports_method("textDocument/formatting") then
		vim.cmd([[
        augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePost <buffer> silent! lua global.lsp.formatting(vim.fn.expand("<abuf>")) 
        augroup END
        ]])
	end
end

-- why did I add this again?
configs.tailwindcss = {
	default_config = {
		cmd = { "tailwindcss-language-server", "--stdio" },
		filetypes = {
			"html",
			"javascriptreact",
			"typescriptreact",
			"vue",
			"svelte",
		},
		init_options = {},
		on_new_config = function(new_config)
			if not new_config.settings then
				new_config.settings = {}
			end
			if not new_config.settings.editor then
				new_config.settings.editor = {}
			end
			if not new_config.settings.editor.tabSize then
				new_config.settings.editor.tabSize =
					vim.lsp.util.get_effective_tabstop()
			end
		end,
		root_dir = lspconfig.util.root_pattern(
			"tailwind.config.js",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.ts",
			"package.json",
			"node_modules",
			".git"
		),
		settings = {
			tailwindCSS = {
				classAttributes = {
					"class",
					"className",
					"classList",
					"ngClass",
				},
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "warning",
				},
				validate = true,
			},
		},
	},
}

-- json server setup
lspconfig.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		json = {
			schemas = require("schemastore").json.schemas({
				select = {
					".eslintrc",
					"package.json",
					"tsconfig.json",
					"tslint.json",
					"jsconfig.json",
					"Serverless Framework Configuration",
					-- "serverless.template",
					-- "*.sam.json",
					-- "*.sam.yml",
					-- "*.sam.yaml",
					-- "sam.json",
					-- "sam.yml",
					-- "sam.yaml",
				},
			}),
		},
	},
})

-- use this when default ain't doing it's thing
-- python server setup
-- lspconfig.pyright.setup({
-- 	on_attach=on_attach,
-- 	capabilities=capabilities,
-- 	root_dir = lspconfig.util.root_pattern('.py'),
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- 	settings= {
-- 		python = {
-- 			analysis = {
-- 				autoSearchPaths = false,
-- 				diagnosticMode = 'workspace',
-- 				useLibraryCodesForTypes = false
-- 			}
-- 		}
-- 	}
-- })

-- typescript server setup
lspconfig.tsserver.setup({
	root_dir = lspconfig.util.root_pattern("package.json"),
	init_options = ts_utils.init_options,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)

		ts_utils.setup({
			import_all_scan_buffers = 100,
			auto_inlay_hints = false,
			update_imports_on_move = true,
			filter_out_diagnostics_by_code = { 80001 },
		})
		ts_utils.setup_client(client)
		bufmap(bufnr, "n", "gs", ":TSLspOrganize<CR>")
		bufmap(bufnr, "n", "gI", ":TSLspRenameFile<CR>")
		bufmap(bufnr, "n", "go", ":TSLspImportAll<CR>")
	end,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
})

-- null-ls setup
local sources = {
	b.formatting.prettier,
	b.formatting.goimports,
	b.formatting.stylua,
	-- b.hover.dictionary,
	b.completion.spell.with({
		filetypes = { "markdown" },
	}),
	b.diagnostics.write_good,
}

null_ls.setup({
	sources = sources,
	on_attach = on_attach,
})

for _, lsp in ipairs({
	"gopls",
	"html",
	"cssls",
	"rust_analyzer",
	"tailwindcss",
	"pyright",
}) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

-- suppress lspconfig messages
local notify = vim.notify
vim.notify = function(msg, ...)
	if msg:match("%[lspconfig%]") then
		return
	end
	notify(msg, ...)
end
