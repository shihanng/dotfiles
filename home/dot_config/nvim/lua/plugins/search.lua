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
    {
        "MagicDuck/grug-far.nvim",
        -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
        -- additional lazy config to defer loading is not really needed...
        config = function()
            -- optional setup call to override plugin options
            -- alternatively you can set options with vim.g.grug_far = { ... }
            require("grug-far").setup({
                -- options, see Configuration section below
                -- there are no required options atm
            })
        end,
    },
    {
        "andymass/vim-matchup",
        init = function()
            -- modify your configuration vars here
            vim.g.matchup_treesitter_stopline = 500

            -- or call the setup function provided as a helper. It defines the
            -- configuration vars for you
            require("match-up").setup({
                treesitter = {
                    stopline = 500,
                },
            })
        end,
    },
}
