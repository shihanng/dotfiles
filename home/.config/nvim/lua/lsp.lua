local lsp = require("lspconfig")

local sumneko_lua_setup = require("lsp_setups/sumneko_lua")
local efm_setup = require("lsp_setups/efm")

lsp.sumneko_lua.setup(sumneko_lua_setup)
lsp.efm.setup(efm_setup)
