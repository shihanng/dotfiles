require("nvim-dap-virtual-text").setup()
require("telescope").load_extension("dap")

require("mason-nvim-dap").setup({
	ensure_installed = { "delve", "python" },
	automatic_setup = false,
})

require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

local dap_go = require("dap-go")
local dap_ui = require("dapui")

dap_go.setup()
dap_ui.setup()

vim.api.nvim_set_keymap("n", "<Leader>dc", ":Telescope dap configurations<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dn", ":lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dv", ":lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>di", ":lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>do", ":lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dk", ":lua require'dap'.up()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dj", ":lua require'dap'.down()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>dt", ":lua require'dap'.terminate()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<M-k>", ":lua require'dapui'.eval()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>df", ":Telescope dap frames<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>db", ":Telescope dap list_breakpoints<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<Leader>d?",
	":lua require'dapui'.float_element('scopes', {enter=true})<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>ds",
	":lua require'dapui'.float_element('stacks', {enter=true})<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>b",
	":lua require'dap'.toggle_breakpoint()<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>B",
	":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>lp",
	":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>de",
	":lua require'dapui'.float_element('repl', {enter=true})<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<Leader>dl", ":lua require'dap'.run_last()<CR>", { noremap = true, silent = true })

-- Customizing color scheme in dap-ui
-- https://github.com/rcarriga/nvim-dap-ui/blob/e5c32746aa72e39267803fdf6934d79541d39f42/lua/dapui/config/highlights.lua#L1
-- https://github.com/rcarriga/nvim-dap-ui/issues/46#issuecomment-899025715
vim.cmd([[hi! link DapUILineNumber LineNr]])
vim.cmd([[hi! link DapUIBreakpointsLine LineNr]])
vim.cmd([[hi! link DapUIBreakpointsCurrentLine LineNr]])

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "", texthl = "healthSuccess", linehl = "healthSuccess", numhl = "healthSuccess" }
)
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "ﳁ", texthl = "healthSuccess", linehl = "healthSuccess", numhl = "healthSuccess" }
)
vim.fn.sign_define(
	"DapBreakpointRejected",
	{ text = "", texthl = "healthSuccess", linehl = "healthSuccess", numhl = "healthSuccess" }
)
vim.fn.sign_define(
	"DapLogPoint",
	{ text = "", texthl = "healthWarning", linehl = "healthWarning", numhl = "healthWarning" }
)
vim.fn.sign_define(
	"DapStopped",
	{ text = "", texthl = "healthError", linehl = "healthError", numhl = "healthError" }
)

vim.cmd("au FileType dap-repl lua require('dap.ext.autocompl').attach()")
