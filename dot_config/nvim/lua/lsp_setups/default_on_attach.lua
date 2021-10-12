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

local function default_on_attach(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local opts = {noremap = true, silent = true}

    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
        vim.api.nvim_exec(
            [[
augroup lsp_format
  autocmd! * <buffer>
  autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_seq_sync({}, 10000)
augroup END
            ]],
            true
        )
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
hi link LspReferenceRead Visual
hi link LspReferenceText Visual
hi link LspReferenceWrite Visual
augroup lsp_document_highlight
  autocmd! * <buffer>
  autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
augroup END
            ]],
            false
        )
    end

    require("folding").on_attach()
end

return default_on_attach
