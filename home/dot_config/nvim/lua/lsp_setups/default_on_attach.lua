-- See: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/390#issuecomment-984850679
-- local format_async = function(err, result, ctx)
--     if err ~= nil or result == nil then
--         return
--     end
--
--     local bufnr = ctx.bufnr
--     if not vim.api.nvim_buf_get_option(bufnr, "modified") then
--         local view = vim.fn.winsaveview()
--         vim.lsp.util.apply_text_edits(result, bufnr)
--         vim.fn.winrestview(view)
--         if bufnr == vim.api.nvim_get_current_buf() then
--             vim.api.nvim_command("noautocmd :update")
--         end
--     end
-- end
--
-- vim.lsp.handlers["textDocument/formatting"] = format_async

-- Setup to only use one LSP for formatting.
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- Get client name from :LspInfo
			no_format_list = {
				terraformls = true,
				gopls = true,
			}

			return not no_format_list[client.name]
		end,
		bufnr = bufnr,
		timeout_ms = 2000,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function default_on_attach(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
	end

	if client.supports_method("textDocument/rangeFormatting") then
		buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	if client.supports_method("textDocument/documentHighlight") then
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
end

return default_on_attach
