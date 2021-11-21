local lsp = require'lspconfig'
	
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true

local servers = {'gopls','html','tsserver'}

for _,lsp in ipairs(servers) do
	require('lspconfig')[lsp].setup {
		capabilities = capabilities
	}
end
