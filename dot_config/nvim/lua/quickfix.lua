vim.g.qfenter_keymap = {
    vopen = {"<C-v>"},
    hopen = {"<C-x>"},
    open = {"<CR>"}
}

vim.api.nvim_set_keymap("n", "<leader>qq", [[<Plug>(qf_qf_toggle)]], {})
