local on_attach = require("lsp_setups/default_on_attach")

local solargraph_path = "solargraph"

local M = {
    cmd = {solargraph_path, "stdio"},
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end
}

return M
