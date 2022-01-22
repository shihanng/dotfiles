local null_ls = require("null-ls")

local on_attach = require("lsp_setups/default_on_attach")

local M = {
	on_attach = on_attach,
	sources = {
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.diagnostics.luacheck,
		null_ls.builtins.formatting.clang_format.with({
			filetypes = { "c", "cpp", "cs", "java", "proto" },
		}),
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.prettierd,

		-- https://github.com/JohnnyMorganz/StyLua
		-- Manually install the binary from release into ~/bin
		null_ls.builtins.formatting.stylua,
	},
}
return M
