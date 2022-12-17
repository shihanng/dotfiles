local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
	"gopls",
	"ltex",
})

lsp.nvim_workspace()

lsp.configure("gopls", {
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})

-- Setup to only use one LSP for formatting.
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
local lsp_formatting = function(options)
	local opts = options or {}
	opts.filter = function(client)
		-- Get client name from :LspInfo
		local no_format_list = {
			terraformls = true,
			gopls = true,
			pyright = true,
		}

		return not no_format_list[client.name]
	end
	opts.timeout_ms = 2000

	vim.lsp.buf.format(opts)
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	local bind = vim.keymap.set

	bind("n", "<leader>rn", vim.lsp.buf.rename, opts)
	bind("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	bind("n", "<space>e", vim.diagnostic.open_float, opts)
	bind("n", "[d", vim.diagnostic.goto_prev, opts)
	bind("n", "]d", vim.diagnostic.goto_next, opts)

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting({ bufnr = bufnr })
			end,
		})
		vim.keymap.set("n", "<space>f", lsp_formatting, opts)
	end

	if client.supports_method("textDocument/rangeFormatting") then
		vim.keymap.set("v", "<space>f", lsp_formatting, opts)
	end
end)

lsp.setup()

local null_ls = require("null-ls")
local null_ls_helpers = require("null-ls.helpers")
local null_opts = lsp.build_options("null-ls", {})

-- Copy from default_setup.
-- What about other LSPs?
local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
		on_output = null_ls_helpers.diagnostics.from_errorformat(
			table.concat({
				[[%l|%m]],
				[[%-G\\s%#]],
			}, ","),
			"checkmake"
		),
	}),
}

null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)
		--- you can add other stuff here....
	end,
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
		null_ls.builtins.formatting.prettierd.with({
			filetypes = {
				"astro",
				"css",
				"graphql",
				"handlebars",
				"html",
				"javascript",
				"javascriptreact",
				"json",
				"jsonc",
				"less",
				"markdown",
				"markdown.mdx",
				"scss",
				"typescript",
				"typescriptreact",
				"vue",
				"yaml",
			},
		}),
		null_ls.builtins.formatting.stylua,
	},
})
