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

local default_setup = require("lsp_setups/default_setup")

lsp.efm.setup(require("lsp_setups/efm"))
lsp.gopls.setup(require("lsp_setups/gopls"))
lsp.graphql.setup(default_setup)
lsp.jsonls.setup(default_setup)
lsp.pyright.setup(default_setup)
lsp.solargraph.setup(require("lsp_setups/solargraph"))
lsp.sqls.setup(require("lsp_setups/sqls"))
lsp.sumneko_lua.setup(require("lsp_setups/sumneko_lua"))
lsp.terraformls.setup(default_setup)
lsp.tflint.setup(default_setup)
lsp.tsserver.setup(require("lsp_setups/tsserver"))
