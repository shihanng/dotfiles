vim.api.nvim_set_keymap("", "<Leader>pg", [[:%!pg_format -L - <cr>]], {noremap = true})
vim.api.nvim_set_keymap("", "<Leader>jq", [[:%!jq '.'<cr>]], {noremap = true})
