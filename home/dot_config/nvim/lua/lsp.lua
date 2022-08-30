local lsp = require("lspconfig")

local default_setup = require("lsp_setups/default_setup")
local null_ls = require("null-ls")

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = { Error = "ﮖ ", Warn = " ", Hint = "ﯦ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Use color that does have same background color
local hi_normal = vim.api.nvim_get_hl_by_name("Normal", true)
vim.api.nvim_set_hl(0, "NormalFloat", hi_normal)

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#borders
local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}
-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local ftMap = {
	-- vim = "indent",
	-- python = { "indent" },
	-- git = "",
}

local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = ("  %d "):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
end

-- global handler
require("ufo").setup({
	fold_virt_text_handler = handler,
})

require("ufo").setup({
	open_fold_hl_timeout = 150,
	close_fold_kinds = { "imports", "comment" },
	preview = {
		win_config = {
			border = { "", "─", "", "", "", "─", "", "" },
			winhighlight = "Normal:Folded",
			winblend = 0,
		},
		mappings = {
			scrollU = "<C-u>",
			scrollD = "<C-d>",
		},
	},
	fold_virt_text_handler = handler,
	provider_selector = function(bufnr, filetype, buftype)
		-- return a string type use internal providers
		-- return a string in a table like a string type
		-- return empty string '' will disable any providers
		-- return `nil` will use default value {'lsp', 'indent'}

		-- if you prefer treesitter provider rather than lsp,
		-- return ftMap[filetype] or {'treesitter', 'indent'}
		return ftMap[filetype]
	end,
})
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set("n", "K", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end)

lsp.bashls.setup(default_setup)
lsp.ccls.setup(default_setup)
lsp.cssls.setup(require("lsp_setups/cssls"))
lsp.efm.setup(require("lsp_setups/efm"))
lsp.elixirls.setup(require("lsp_setups/elixirls"))
lsp.gopls.setup(require("lsp_setups/gopls"))
lsp.graphql.setup(default_setup)
lsp.jsonls.setup(require("lsp_setups/jsonls"))
lsp.pyright.setup(default_setup)
lsp.solargraph.setup(require("lsp_setups/solargraph"))
lsp.sqls.setup(require("lsp_setups/sqls"))
lsp.sumneko_lua.setup(require("lsp_setups/sumneko_lua"))
lsp.terraformls.setup(require("lsp_setups/terraformls"))
lsp.tflint.setup(default_setup)
lsp.tsserver.setup(require("lsp_setups/tsserver"))
null_ls.setup(require("lsp_setups/nullls"))
