require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	ignore_install = { "haskell" },
	indent = {
		enable = true,
	},
	highlight = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	autotag = {
		enable = true,
	},
	textsubjects = {
		enable = true,
		prev_selection = ",", -- (Optional) keymap to select the previous selection
		keymaps = {
			["."] = "textsubjects-smart",
			[";"] = "textsubjects-container-outer",
			["i;"] = "textsubjects-container-inner",
		},
	},
})

vim.g.nvcode_termcolors = 256

vim.opt.syntax = "on"

vim.cmd([[colorscheme nord]])

if vim.fn.has("termguicolors") == 1 then
	vim.opt.termguicolors = true
end

-- This make sure that the statusline for dap-ui is not changing when the window is active.
-- https://github.com/rcarriga/nvim-dap-ui/issues/50#issuecomment-905804897
local dap_line = {
	sections = { lualine_c = { "filename" } },
	filetypes = { "dapui_watches", "dapui_stacks", "dapui_scopes", "dapui_breakpoints", "dap-repl" },
}
require("lualine").setup({
	options = {
		theme = "nord",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
	extensions = { dap_line, "fugitive", "quickfix", "nvim-tree" },
})

require("gitsigns").setup()

vim.api.nvim_set_keymap(
	"n",
	"<Leader>ch",
	[[:center 80<cr>hhv0r=A<space><esc>40A=<esc>:Commentary<cr><esc>81<bar>D]],
	{ silent = true }
)

-- https://github.com/tversteeg/registers.nvim
vim.api.nvim_set_var("registers_window_border", "rounded")
vim.api.nvim_set_var("registers_window_max_width", 40)
