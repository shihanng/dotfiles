require("nvim-dap-virtual-text").setup()
require("telescope").load_extension("dap")
require("mason-nvim-dap").setup({
	ensure_installed = { "delve", "python" },
	automatic_setup = false,
})
require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
require("dap-go").setup({
	dap_configurations = {
		{
			type = "go",
			name = "Attach remote",
			mode = "remote",
			request = "attach",
		},
	},
	delve = {
		port = "38697",
	},
})

local dap = require("dap")

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/" .. "mason" .. "/" .. "bin" .. "/" .. "codelldb",
		args = { "--port", "${port}" },

		-- On windows you may have to uncomment this:
		-- detached = false,
	},
}

require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "rust" } })

local dap_ui = require("dapui")

dap_ui.setup()

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<F1>", require("dap").step_over, opts)
vim.keymap.set("n", "<F2>", require("dap").step_into, opts)
vim.keymap.set("n", "<F3>", require("dap").step_out, opts)
vim.keymap.set("n", "<F5>", require("dap").continue, opts)
vim.keymap.set("n", "<F6>", require("dap").run_to_cursor, opts)
vim.keymap.set("n", "<F9>", require("dap").up, opts)
vim.keymap.set("n", "<F10>", require("dap").down, opts)
vim.keymap.set("n", "<Leader>dt", require("dap").terminate, opts)
vim.keymap.set("n", "<Leader>db", require("telescope").extensions.dap.list_breakpoints, opts)
vim.keymap.set("n", "<Leader>b", require("dap").toggle_breakpoint, opts)
vim.keymap.set("n", "<Leader>B", function()
	dap.set_breakpoint(vim.fn.input("Cond: "))
end, opts)
vim.keymap.set("n", "<Leader>dd", dap_ui.toggle)

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

dap.listeners.after.event_initialized["dapui_config"] = function()
	dap_ui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dap_ui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dap_ui.close()
end
