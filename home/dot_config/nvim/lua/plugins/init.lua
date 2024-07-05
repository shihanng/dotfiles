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
    {
        "https://git.sr.ht/~swaits/zellij-nav.nvim",
        lazy = true,
        event = "VeryLazy",
        keys = {
            { "<c-h>", "<cmd>ZellijNavigateLeft<cr>", { silent = true, desc = "navigate left" } },
            { "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" } },
            { "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" } },
            { "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
        },
        opts = {},
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^4", -- Recommended
        ft = { "rust" },
    },
}
