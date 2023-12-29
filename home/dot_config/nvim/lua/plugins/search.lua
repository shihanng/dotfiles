return {
    "haya14busa/is.vim",
    {
        "haya14busa/vim-asterisk",
        config = function()
            vim.g["asterisk#keeppos"] = 1

            vim.api.nvim_set_keymap("n", "*", [[<Plug>(asterisk-z*)<Plug>(is-nohl-1)]], {})
            vim.api.nvim_set_keymap("", "*", [[<Plug>(asterisk-z*)<Plug>(is-nohl-1)]], {})
            vim.api.nvim_set_keymap("", "g*", [[<Plug>(asterisk-gz*)<Plug>(is-nohl-1)]], {})
            vim.api.nvim_set_keymap("", "#", [[<Plug>(asterisk-z#)<Plug>(is-nohl-1)]], {})
            vim.api.nvim_set_keymap("", "g#", [[<Plug>(asterisk-gz#)<Plug>(is-nohl-1)]], {})
        end,
    },
}
