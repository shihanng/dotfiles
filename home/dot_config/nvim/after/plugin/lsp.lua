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
	"astro",
	"bashls",
	"cssls",
	"efm",
	"elixirls",
	"gopls",
	"graphql",
	"jsonls",
	"ltex",
	"pyright",
	"solargraph",
	"sumneko_lua",
	"terraformls",
	"tflint",
	"tsserver",
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

lsp.configure("efm", {
	capabilities = capabilities,
	settings = {
		filetypes = {
			"elixir",
			"eruby",
			"ruby",
			"sh",
			"sql",
		},
		init_options = {
			documentFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
	},
})

lsp.configure("ccls", {
	force_setup = true,
	capabilities = capabilities,
})

local tsserver_opts = lsp.build_options("tsserver", {
	on_attach = function(_, _)
		local opts = { noremap = true, silent = true }
		local bind = vim.keymap.set

		bind("n", "gs", require("typescript").actions.organizeImports, opts)
		bind("n", "gI", require("typescript").actions.addMissingImports, opts)
	end,
})

-- share options between serveral servers
local lsp_opts = {
	capabilities = capabilities,
}

lsp.setup_servers({
	"astro",
	"bashls",
	"cssls",
	"elixir-ls",
	"graphql",
	"jsonls",
	"ltex",
	"pyright",
	"solargraph",
	"sumneko_lua",
	"terraformls",
	"tflint",
	"tsserver",
	opts = lsp_opts,
})

-- Setup to only use one LSP for formatting.
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
local lsp_formatting = function(options)
	local opts = options or {}
	opts.filter = function(client)
		-- Get client name from :LspInfo
		local no_format_list = {
			gopls = true,
			jsonls = true,
			pyright = true,
			sumneko_lua = true,
			terraformls = true,
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

	if client.server_capabilities.documentFormattingProvider then
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

	if client.server_capabilities.documentRangeFormattingProvider then
		vim.keymap.set("v", "<space>f", lsp_formatting, opts)
	end
end)

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
})

lsp.nvim_workspace()

lsp.setup()

-- https://github.com/VonHeikemen/lsp-zero.nvim/discussions/39
require("typescript").setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	server = tsserver_opts,
})

require("mason-null-ls").setup({
	ensure_installed = {
		"black",
		"clang_format",
		"eslint_d",
		"flake8",
		"goimports",
		"golangci_lint",
		"isort",
		"luacheck",
		"mypy",
		"prettierd",
		"stylua",
	},
})

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)
		--- you can add other stuff here....
	end,
	capabilities = capabilities,
	sources = {
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.diagnostics.checkmake,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.diagnostics.luacheck,
		null_ls.builtins.diagnostics.mypy,
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
		require("typescript.extensions.null-ls.code-actions"),
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

-- https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

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
