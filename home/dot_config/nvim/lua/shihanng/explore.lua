vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true })

vim.g["asterisk#keeppos"] = 1

-- Find and replace (by Nick Janetakis)
vim.api.nvim_set_keymap("n", "<Leader>rr", [[:%s///g<Left><Left>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>rc", [[:%s///gc<Left><Left><Left>]], { noremap = true })
vim.api.nvim_set_keymap("x", "<Leader>rr", [[:s///g<Left><Left>]], { noremap = true })
vim.api.nvim_set_keymap("x", "<Leader>rc", [[:s///gc<Left><Left><Left>]], { noremap = true })

vim.api.nvim_set_keymap("n", "*", [[<Plug>(asterisk-z*)<Plug>(is-nohl-1)]], {})
vim.api.nvim_set_keymap("", "*", [[<Plug>(asterisk-z*)<Plug>(is-nohl-1)]], {})
vim.api.nvim_set_keymap("", "g*", [[<Plug>(asterisk-gz*)<Plug>(is-nohl-1)]], {})
vim.api.nvim_set_keymap("", "#", [[<Plug>(asterisk-z#)<Plug>(is-nohl-1)]], {})
vim.api.nvim_set_keymap("", "g#", [[<Plug>(asterisk-gz#)<Plug>(is-nohl-1)]], {})

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>xw",
	"<cmd>TroubleToggle workspace_diagnostics<cr>",
	{ silent = true, noremap = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>xd",
	"<cmd>TroubleToggle document_diagnostics<cr>",
	{ silent = true, noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })

vim.api.nvim_set_keymap("n", "<F5>", [[:UndotreeToggle<CR>]], { noremap = true })

require("nvim-tree").setup({
	hijack_cursor = true,
	update_focused_file = {
		enable = true,
		ignore_list = {},
	},
	actions = {
		open_file = {
			quit_on_open = true,
			window_picker = {
				enable = false,
			},
		},
	},
	view = {
		mappings = {
			custom_only = false,
			list = {
				{ key = "[", action = "first_sibling" },
				{ key = "]", action = "last_sibling" },
				{ key = "K", action = "toggle_file_info" },
			},
		},
	},
})
