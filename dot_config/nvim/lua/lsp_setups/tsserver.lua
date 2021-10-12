local on_attach = require("lsp_setups/default_on_attach")

local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local M = {
    cmd = {"typescript-language-server", "--stdio"},
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":OrganizeImports<CR>", {noremap = true, silent = true})
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
        }
    }
}

return M
