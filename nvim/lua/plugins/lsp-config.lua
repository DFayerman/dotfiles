local lspconfig = require'lspconfig'
local configs = require'lspconfig.configs'
local nvim_cmp = require'cmp_nvim_lsp'
local null_ls = require'null-ls'
local ts_utils = require("nvim-lsp-ts-utils")
local b = null_ls.builtins

local border_opts = { 
	border = "rounded",
	focusable = false,
	scope = "line" 
}

vim.diagnostic.config({ virtual_text = false, float = border_opts })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, border_opts)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border_opts)

-- remap helper
local bufmap = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

-- -- golang import on save
-- function goimports(timeout_ms)
--     local context = { only = { "source.organizeImports" } }
--     vim.validate { context = { context, "t", true } }
--     local params = vim.lsp.util.make_range_params()
--     params.context = context
--     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
--     if not result or next(result) == nil then return end
--     local actions = result[1].result
--     if not actions then return end
--     local action = actions[1]
--     if action.edit or type(action.command) == "table" then
--       if action.edit then
--         vim.lsp.util.apply_workspace_edit(action.edit)
--       end
--       if type(action.command) == "table" then
--         vim.lsp.buf.execute_command(action.command)
--       end
--     else
--       vim.lsp.buf.execute_command(action)
--     end
-- end

-- vim.api.nvim_exec([[ autocmd BufWritePre *.go lua goimports(1000) ]], false)

local preferred_formatting_clients = { "eslint_d","tsserver" }
local fallback_formatting_client = "null-ls"
local formatting = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local selected_client
    for _, client in ipairs(vim.lsp.get_active_clients()) do
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
    local result, err = selected_client.request_sync("textDocument/formatting", params, 5000, bufnr)
    if result and result.result then
        vim.lsp.util.apply_text_edits(result.result, bufnr)
    elseif err then
        vim.notify("global.lsp.formatting: " .. err, vim.log.levels.WARN)
    end
end

global.lsp = {
    border_opts = border_opts,
    formatting = formatting
}

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = nvim_cmp.update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true


-- custom on_attach (mappings)
local on_attach = function(client, bufnr)
	local opts = { noremap=true, silent=true }
  bufmap(bufnr,'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  bufmap(bufnr,'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  bufmap(bufnr,'n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	bufmap(bufnr,'i', '<C-x>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	bufmap(bufnr,'n','<Leader>a', '<cmd>lua vim.diagnostic.open_float(nil,global.lsp.border_opts)<CR>',opts)
	-- bufmap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	-- bufmap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- bufmap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- bufmap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua global.lsp.formatting()")
	end
end

-- emmet server config
configs.ls_emmet = {
  default_config = {
    cmd = { 'ls_emmet', '--stdio' };
    filetypes = { 'html', 'css', 'scss', 'javascriptreact', 'typescriptreact', 'xml', 'pug', 'sass'};
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
			ts_utils.setup({
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
		}
}

-- eslint setup 
-- lspconfig.eslint.setup({
-- 		root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js"),
-- 		on_attach = function(client, bufnr)
-- 				client.resolved_capabilities.document_formatting = true
-- 				on_attach(client, bufnr)
-- 		end,
-- 		capabilities = capabilities,
-- 		settings = {
-- 				format = {
-- 						enable = true,
-- 				},
-- 		},
-- 		flags = {
-- 			debounce_text_changes = 150,
-- 		},
-- })

-- null-ls setup
local sources = {
	b.formatting.prettier.with({
		disabled_filetypes = {
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact"
		}
	}),
	-- b.diagnostics.markdownlint,
	b.hover.dictionary,
	b.formatting.goimports,
	b.formatting.sqlformat.with({
		extra_args = { "-a" }
	}),
	b.formatting.stylua,
}

null_ls.setup({
    sources = sources,
    on_attach = on_attach,
})

for _,lsp in ipairs({ 
	'gopls',
	'html',
	-- 'tsserver',
	'cssls', 
	'rust_analyzer',
	"ls_emmet",
	-- 'eslint',
	'tailwindcss',
	'pyright'
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

-- suppress lspconfig messages
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("%[lspconfig%]") then
        return
    end

    notify(msg, ...)
end
