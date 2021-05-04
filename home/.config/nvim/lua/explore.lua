local actions = require("telescope.actions")
require("telescope").setup {
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        mappings = {
            i = {
                ["<esc>"] = actions.close
            }
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true
        }
    }
}
require("telescope").load_extension("fzy_native")

vim.api.nvim_set_keymap("n", "<C-p>", ":lua require('explore').project_files()<cr>", {noremap = true})
vim.api.nvim_set_keymap(
    "n",
    "<C-b>",
    ":lua require('telescope.builtin').buffers({show_all_buffers=true})<cr>",
    {noremap = true}
)
vim.api.nvim_set_keymap("n", "<C-f>", ":lua require('telescope.builtin').live_grep()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-n>", ":lua require('explore').open_tree()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", {noremap = true})

vim.g.nvim_tree_quit_on_open = 1

-- Fallback to find_files if not in git directory.
-- This does not work as expected because pcall return true.
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
local M = {}

M.project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require "telescope.builtin".git_files, opts)
    if not ok then
        require "telescope.builtin".find_files(opts)
    end
end

M.open_tree = function()
    local nt = require "nvim-tree"
    local ok = pcall(nt.find_file, true)
    if not ok then
        nt.open()
    end
end

return M
