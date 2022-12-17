local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local builtin = require("telescope.builtin")

require("telescope").setup({
	defaults = {
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<c-t>"] = trouble.open_with_trouble,
			},
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	},
})
require("telescope").load_extension("fzy_native")

vim.keymap.set("n", "<C-f>", builtin.live_grep, { noremap = true })
vim.keymap.set("n", "<C-b>", function()
	builtin.buffers({ show_all_buffers = true })
end, { noremap = true })
vim.keymap.set("n", "<C-p>", function()
	-- Fallback to find_files if not in git directory.
	-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
	vim.fn.system("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error == 0 then
		builtin.git_files({ show_untracked = true })
	else
		builtin.find_files()
	end
end, { noremap = true })
