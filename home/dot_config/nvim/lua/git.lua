vim.api.nvim_set_keymap("n", "<leader>gs", [[:G<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>g]", [[:diffget //3<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>g[", [[:diffget //2<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>gd", [[:Gvdiff!<CR>]], {})

vim.cmd([[ command! -nargs=1 Browse silent exec '!open "<args>"' ]])
