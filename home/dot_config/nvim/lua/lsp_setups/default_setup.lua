local on_attach = require("lsp_setups/default_on_attach")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local M = {
    on_attach = on_attach,
    capabilities = capabilities
}

return M
