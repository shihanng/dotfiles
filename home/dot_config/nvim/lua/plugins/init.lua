return {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "norcalli/nvim-colorizer.lua",
        config = function() require("colorizer").setup() end,
    },
    "jeffkreeftmeijer/vim-numbertoggle",
    "tpope/vim-repeat",
    "tpope/vim-fugitive",
    "direnv/direnv.vim",
    "mattn/emmet-vim",
    {
        "mrcjkb/rustaceanvim",
        version = "^6", -- Recommended
        lazy = false,
    },
}
