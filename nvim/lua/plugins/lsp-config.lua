local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local nvim_cmp = require("cmp_nvim_lsp")
local null_ls = require("null-ls")
local b = null_ls.builtins

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	virtual_text = { source = "if_many", prefix = "•" },
	float = { border = "rounded", focusable = false, source = "always" },
	signs = true,
})

local border_opts = {
	border = "single",
	focusable = true,
	scope = "line",
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover,
	border_opts
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
	vim.lsp.handlers.signature_help,
	border_opts
)

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = nvim_cmp.update_capabilities(capabilities)

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

-- custom on_attach (mappings)
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	bufmap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	bufmap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	bufmap(bufnr, "n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	-- bufmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	bufmap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	bufmap(bufnr, "n", "<Leader>f", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
	bufmap(bufnr, "n", "<C-x>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	bufmap(bufnr, "i", "<C-x>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	bufmap(bufnr, "n", "<Leader>a", "<cmd>lua vim.diagnostic.open_float(nil)<CR>", opts)

	-- if client.supports_method("textDocument/formatting") then
	-- 		vim.api.nvim_buf_create_user_command(bufnr, "LspFormatting", function()
	-- 				lsp_formatting(bufnr)
	-- 		end, {})
	-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	-- 		vim.api.nvim_create_autocmd("BufWritePre", {
	-- 				buffer = bufnr,
	-- 				command = "LspFormatting",
	-- 		})
	-- end
	require('illuminate').on_attach(client)
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
				},
			}),
		},
	},
})

-- yaml server setup
lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		yaml = {
			schemas = {
				[ "https://raw.githubusercontent.com/lalcebo/json-schema/master/serverless/reference.json" ] = "/*serverless*",
				[ "https://json.schemastore.org/github-workflow.json" ] = "/*workflow*",
			}
		},
	}
})


-- null-ls setup
local sources = {
	-- b.formatting.prettier,
	-- b.formatting.goimports,
	-- b.formatting.stylua,
	b.formatting.shfmt,
	b.hover.dictionary,
	b.diagnostics.write_good,
	b.diagnostics.flake8.with({
		extra_args = { "--ignore", "E501,W505,F841"}
	}),
}

null_ls.setup({
	sources = sources,
	on_attach = on_attach,
})

for _, lsp in ipairs({
	"gopls",
	"html",
	"cssls",
	"tsserver",
	-- "tailwindcss",
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

local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("%[lspconfig%]") then
        return
    end
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end
    notify(msg, ...)
end
