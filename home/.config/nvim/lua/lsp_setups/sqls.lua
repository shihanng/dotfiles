local on_attach = require("lsp_setups/default_on_attach")

local M = {
    on_attach = function(client)
        client.resolved_capabilities.execute_command = true
        on_attach(client)
        require "sqls".setup {
            picker = "telescope"
        }
    end
}

return M
