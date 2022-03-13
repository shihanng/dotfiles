local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local on_attach = require("lsp_setups/default_on_attach")

local checkmake = {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { "make" },
	generator = null_ls.generator({
		command = "checkmake",
		args = {
			[[--format]],
			[[{{.LineNumber}}|{{.Rule}}: {{.Violation}}{{"\n"}}]],
			"$FILENAME",
		},
		to_stdin = false,
		from_stderr = true,
		format = "raw",
		to_temp_file = true,
		on_output = helpers.diagnostics.from_errorformat(
			table.concat({
				[[%l|%m]],
				[[%-G\\s%#]],
			}, ","),
			"checkmake"
		),
	}),
}

local M = {
	debug = true,
	on_attach = on_attach,
	sources = {
		checkmake,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.code_actions.eslint_d,
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
