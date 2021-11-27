local lspconfig = require'lspconfig'
local configs = require'lspconfig.configs'
local nvim_cmp = require'cmp_nvim_lsp'
	
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = nvim_cmp.update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local opts = { noremap=true, silent=true }

	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	
end

-- configs.gopls = {
-- 	default_config = {
-- 	 cmd = { "gopls" };
--     filetypes = { "go", "gomod" };
--     root_dir = function(fname)
--       return util.root_pattern 'go.work'(fname) or util.root_pattern('go.mod', '.git')(fname)
--     end;
-- 		settings = { };
-- 	};
-- }

configs.ls_emmet = {
  default_config = {
    cmd = { 'ls_emmet', '--stdio' };
    filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'haml',
      'xml', 'xsl', 'pug', 'slim', 'sass', 'stylus', 'less', 'sss'};
    root_dir = function(fname)
      return vim.loop.cwd()
    end;
    settings = {};
  };
}

local servers = { 'gopls','html','tsserver','ls_emmet'}
for _,lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}
end
