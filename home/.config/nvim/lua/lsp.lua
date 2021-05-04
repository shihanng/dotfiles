local lsp = require("lspconfig")

-- Support format on save
-- Ref: https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end
vim.lsp.handlers["textDocument/formatting"] = format_async

local sumneko_lua_setup = require("lsp_setups/sumneko_lua")
local efm_setup = require("lsp_setups/efm")

lsp.sumneko_lua.setup(sumneko_lua_setup)
lsp.efm.setup(efm_setup)
