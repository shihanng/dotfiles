local on_attach = require("lsp_setups/default_on_attach")

local solargraph_path = "solargraph"

local M = {
    cmd = {solargraph_path, "stdio"},
    on_attach = on_attach
}

return M
