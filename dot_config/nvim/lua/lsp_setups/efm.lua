local on_attach = require("lsp_setups/default_on_attach")

local M = {
    filetypes = {
        "elixir",
        "eruby",
        "lua",
        "ruby",
        "sh",
        "sql"
    },
    init_options = {
        documentFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true
    },
    on_attach = on_attach
}

return M
