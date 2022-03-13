local on_attach = require("lsp_setups/default_on_attach")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local M = {
	capabilities = capabilities,
	on_attach = on_attach,
}

return M
