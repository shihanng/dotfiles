return {
    { "rose-pine/neovim", name = "rose-pine" },
    "cohama/lexima.vim",
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup()
        end,
    },
    "nvim-treesitter/nvim-treesitter-context",
    "tpope/vim-surround",
    "jeffkreeftmeijer/vim-numbertoggle",
    "tpope/vim-repeat",
    {
        "junegunn/vim-easy-align",
        config = function()
            vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")
            vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")
        end,
    },
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "direnv/direnv.vim",
    "mattn/emmet-vim",
}
