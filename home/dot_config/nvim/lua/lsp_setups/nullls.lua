local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local on_attach = require("lsp_setups/default_on_attach")

-- Copy from default_setup.
-- What about other LSPs?
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

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
	on_attach = on_attach,
	capabilities = capabilities,
	sources = {
		checkmake,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.diagnostics.luacheck,
		null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
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
