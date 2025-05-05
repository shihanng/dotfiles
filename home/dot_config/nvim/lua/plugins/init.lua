return {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "norcalli/nvim-colorizer.lua",
        config = function() require("colorizer").setup() end,
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("gitsigns").setup() end,
    },
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
    "direnv/direnv.vim",
    "mattn/emmet-vim",
    {
        "mrcjkb/rustaceanvim",
        version = "^6", -- Recommended
        lazy = false,
    },
}
