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
})

vim.g.nvcode_termcolors = 256

vim.opt.syntax = "on"

vim.cmd([[colorscheme nord]])

if vim.fn.has("termguicolors") == 1 then
	vim.opt.termguicolors = true
end

require("lualine").setup({
	options = {
		theme = "nord",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
})

require("lspkind").init({})
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
