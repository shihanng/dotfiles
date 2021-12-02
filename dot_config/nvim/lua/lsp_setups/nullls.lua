local null_ls = require("null-ls")

local M = {
    debug = true,
    sources = {
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.diagnostics.golangci_lint
    }
}

return M
