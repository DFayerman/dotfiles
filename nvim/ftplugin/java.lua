local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local nvim_cmp = require("cmp_nvim_lsp")


local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify "JDTLS not found"
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = nvim_cmp.update_capabilities(capabilities)

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

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

	bufmap(bufnr, "n", "<Leader>o", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
	require('illuminate').on_attach(client)
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = os.getenv("HOME") .. '/.local/share/eclipse/' .. project_name

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    -- '-Xms1g',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.fn.glob('/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', '/usr/share/java/jdtls/config_linux',
    '-data', workspace_dir
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
	on_attach = on_attach,
	capabilities = capabilities,
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
			signatureHelp = { enabled = true },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
			extendedClientCapabilities = extendedClientCapabilities,
			configuration = {
				runtimes = {
					{
						name = "JavaSE-11",
						path = "/usr/lib/jvm/java-11-openjdk/",
					},
					{
						name = "JavaSE-18",
						path = "/usr/lib/jvm/java-18-openjdk/",
					}
				}
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
			},
    }
  }
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
