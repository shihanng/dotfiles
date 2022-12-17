require("nightfox").setup({
	options = {
		styles = {
			comments = "italic",
			keywords = "bold",
			types = "italic,bold",
		},
	},
})

vim.cmd.colorscheme("nightfox")

-- Use color that does have same background color
-- in the LSP diagnostics (the window that shows up during <space>e).
local hi_normal = vim.api.nvim_get_hl_by_name("Normal", true)
vim.api.nvim_set_hl(0, "NormalFloat", hi_normal)