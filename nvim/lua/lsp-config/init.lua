local lspconfig = require'lspconfig'
local configs = require'lspconfig.configs'
local nvim_cmp = require'cmp_nvim_lsp'
local null_ls = require'null-ls'
local ts_utils = require("nvim-lsp-ts-utils")
local b = null_ls.builtins

-- remap helper
local bufmap = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

-- golang import on save
function goimports(timeout_ms)
    local context = { only = { "source.organizeImports" } }
    vim.validate { context = { context, "t", true } }
    local params = vim.lsp.util.make_range_params()
    params.context = context
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
end

vim.api.nvim_exec([[ autocmd BufWritePre *.go lua goimports(1000) ]], false)

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = nvim_cmp.update_capabilities(capabilities)

-- custom on_attach (mappings)
local on_attach = function(client, bufnr)
	local opts = { noremap=true, silent=true }
  bufmap(bufnr,'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  bufmap(bufnr,'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  bufmap(bufnr,'n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	bufmap(bufnr,'i', '<C-x>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	bufmap(bufnr,'n','<Leader>a', '<cmd>lua vim.diagnostic.open_float()<CR>',opts)
	-- bufmap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	-- bufmap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- bufmap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- bufmap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

	if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
end

-- emmet server config
configs.ls_emmet = {
  default_config = {
    cmd = { 'ls_emmet', '--stdio' };
    filetypes = { 'html', 'css', 'scss', 'javascriptreact', 'typescript', 'typescriptreact', 'xml', 'pug', 'sass'};
    root_dir = function(fname)
      return vim.loop.cwd()
    end;
    settings = {};
  };
}

-- typescript server setup
lspconfig.tsserver.setup {
	root_dir = lspconfig.util.root_pattern("package.json"),
	init_options = ts_utils.init_options,
	on_attach=function(client, bufnr)
			on_attach(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
			ts_utils.setup({})
			ts_utils.setup_client(client)
			bufmap(bufnr, "n", "gs", ":TSLspOrganize<CR>")
			bufmap(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
			bufmap(bufnr, "n", "go", ":TSLspImportAll<CR>")
    end,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		}
}

local sources = {
	b.formatting.prettier.with({
		disabled_filetypes = {"typescript","typescriptreact"}
	}),
	null_ls.builtins.diagnostics.eslint_d,
	null_ls.builtins.code_actions.eslint_d,
}

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.formatting.prettier,
    },
    on_attach = on_attach,
})

for _,lsp in ipairs({ 
	'gopls',
	'html',
	-- 'tsserver',
	'cssls', 
	'rust_analyzer',
	"ls_emmet",
	'eslint',
	'tailwindcss',
})
do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}
end
