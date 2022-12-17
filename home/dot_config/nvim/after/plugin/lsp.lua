-- https://github.com/kevinhwang91/nvim-ufo
-- Use :lua =vim.lsp.get_active_clients()[1] to check if foldingRange
-- is properly set.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local lsp = require("lsp-zero")
lsp.preset("recommended")

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
lsp.ensure_installed({
	"gopls",
	"ltex",
	"sumneko_lua",
})

lsp.configure("gopls", {
	capabilities = capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})

-- share options between serveral servers
local lsp_opts = {
	capabilities = capabilities,
}

lsp.setup_servers({
	"ltex",
	"sumneko_lua",
	opts = lsp_opts,
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

lsp.nvim_workspace()

lsp.setup()

local null_ls = require("null-ls")
local null_ls_helpers = require("null-ls.helpers")
local null_opts = lsp.build_options("null-ls", {})

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

local ufo = require("ufo")
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

ufo.setup({
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
	provider_selector = function(_, filetype, _)
		-- return a string type use internal providers
		-- return a string in a table like a string type
		-- return empty string '' will disable any providers
		-- return `nil` will use default value {'lsp', 'indent'}

		-- if you prefer treesitter provider rather than lsp,
		-- return ftMap[filetype] or {'treesitter', 'indent'}
		return ftMap[filetype]
	end,
})

vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)
vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
vim.keymap.set("n", "zm", ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set("n", "K", function()
	local winid = ufo.peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end)
