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

if vim.fn.has("termguicolors") == 1 then
	vim.opt.termguicolors = true
end

-- Shows vim-visual-multi status in lualine
local vim_visual_multi = function()
	local vm_status_ok, VMInfos = pcall(vim.fn.VMInfos)
	-- Check if VMInfos exists, check if the return of VMInfos is {}
	if (not vm_status_ok) or (not next(VMInfos)) then
		return ""
	end

	return "V-M " .. VMInfos["status"] .. " " .. VMInfos["ratio"]
end

-- This make sure that the statusline for dap-ui is not changing when the window is active.
-- https://github.com/rcarriga/nvim-dap-ui/issues/50#issuecomment-905804897
local dap_line = {
	sections = { lualine_a = { { "filename", separator = { left = "", right = "" } } } },
	filetypes = { "dapui_watches", "dapui_stacks", "dapui_scopes", "dapui_breakpoints", "dap-repl" },
}
require("lualine").setup({
	options = {
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
	extensions = { dap_line, "fugitive", "quickfix", "nvim-tree" },
	sections = {
		lualine_a = { "mode", vim_visual_multi },
	},
})

require("gitsigns").setup()

vim.api.nvim_set_keymap(
	"n",
	"<Leader>ch",
	[[:center 80<cr>hhv0r=A<space><esc>40A=<esc>:Commentary<cr><esc>81<bar>D]],
	{ silent = true }
)
