vim.g["test#strategy"] = "vtr"

vim.api.nvim_set_keymap("n", "t<C-n>", ":TestNearest<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "t<C-f>", ":TestFile<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "t<C-l>", ":TestLast<cr>", {silent = true, noremap = true})
