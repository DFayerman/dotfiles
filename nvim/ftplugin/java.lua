local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local nvim_cmp = require("cmp_nvim_lsp")

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
	border = "rounded",
	focusable = false,
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
vim.lsp.handlers["textDocument/definition"] = function(_, result)
  if not result or vim.tbl_isempty(result) then
    print "[LSP] Could not find definition"
    return
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], "utf-8")
  else
    vim.lsp.util.jump_to_location(result, "utf-8")
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = nvim_cmp.update_capabilities(capabilities)

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
	require('illuminate').on_attach(client)
end



local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/usr/share/java/jdtls/config_linux',
    '-data', '$0'
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
	on_attach = on_attach,
	capabilities = capabilities
  -- settings = {
  --   java = {
  --   }
  -- },
  -- init_options = {
  --   bundles = {}
  -- },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
