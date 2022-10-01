local on_attach = require("lsp_setups/default_on_attach")

-- Copy from default_setup.
-- What about other LSPs?
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local M = {
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
}

return M
