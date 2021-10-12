local on_attach = require("lsp_setups/default_on_attach")

local M = {
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true
            },
            staticcheck = true
        }
    },
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end
}

return M
