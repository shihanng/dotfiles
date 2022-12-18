local lsp = require("lspconfig")

local default_setup = require("lsp_setups/default_setup")

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = { Error = "ﮖ ", Warn = " ", Hint = "ﯦ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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

lsp.bashls.setup(default_setup)
lsp.ccls.setup(default_setup)
lsp.cssls.setup(require("lsp_setups/cssls"))
lsp.efm.setup(require("lsp_setups/efm"))
lsp.elixirls.setup(require("lsp_setups/elixirls"))
lsp.graphql.setup(default_setup)
lsp.jsonls.setup(require("lsp_setups/jsonls"))
lsp.pyright.setup(default_setup)
lsp.solargraph.setup(require("lsp_setups/solargraph"))
lsp.sqls.setup(require("lsp_setups/sqls"))
lsp.sumneko_lua.setup(require("lsp_setups/sumneko_lua"))
lsp.terraformls.setup(require("lsp_setups/terraformls"))
lsp.tflint.setup(default_setup)
lsp.tsserver.setup(require("lsp_setups/tsserver"))
