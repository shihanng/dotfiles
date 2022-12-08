local on_attach = require("lsp_setups/default_on_attach")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local M = {
	on_attach = on_attach,
	capabilities = capabilities,
}

return M
