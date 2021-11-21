local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'
local nvim_cmp = require'cmp_nvim_lsp'
	
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = nvim_cmp.update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true

local servers = { 'gopls','html','tsserver', 'emmet_ls'}
for _,lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}
end
