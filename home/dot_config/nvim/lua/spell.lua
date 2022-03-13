vim.opt.spelllang = { "en", "cjk" }

-- Toggle spell checking on and off.
vim.api.nvim_set_keymap("n", "<Leader>s", [[:set spell!<CR>]], { silent = true })
vim.api.nvim_set_keymap("n", "z=", ":lua require('telescope.builtin').spell_suggest()<cr>", { noremap = true })
