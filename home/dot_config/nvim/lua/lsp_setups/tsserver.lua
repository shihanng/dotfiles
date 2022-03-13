local on_attach = require("lsp_setups/default_on_attach")
local ts_utils = require("nvim-lsp-ts-utils")

local M = {
    cmd = {"typescript-language-server", "--stdio"},
    init_options = ts_utils.init_options,
    on_attach = function(client, bufnr)
        -- See https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils#setup
        ts_utils.setup({})
        ts_utils.setup_client(client)
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
}

return M
