require("nvim-dap-virtual-text").setup()

local dap = require("dap")
local dap_go = require("dap-go")
local dap_ui = require("dapui")

dap_go.setup()
dap_ui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dap_ui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dap_ui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dap_ui.close()
end

vim.api.nvim_set_keymap("n", "<F7>", ":lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F8>", ":lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F9>", ":lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F10>", ":lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F11>", ":lua require'dap'.terminate()<CR>", { noremap = true, silent = true })
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
vim.api.nvim_set_keymap("n", "<Leader>de", ":lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })
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
