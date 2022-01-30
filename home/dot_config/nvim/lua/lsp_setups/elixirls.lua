local on_attach = require("lsp_setups/default_on_attach")

local ls_path = vim.fn.expand("~/dev/github.com/elixir-lsp/elixir-ls/rel/language_server.sh")

local M = {
    cmd = {ls_path},
    on_attach = on_attach
}

return M
