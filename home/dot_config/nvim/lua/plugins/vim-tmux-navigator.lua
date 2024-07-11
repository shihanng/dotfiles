return {
    "https://github.com/shihanng/zellij-nav.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
        {
            "<c-h>",
            function() require("zellij-nav").left("move-focus-or-tab") end,
            { silent = true, desc = "navigate left" },
        },
        { "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" } },
        { "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" } },
        {
            "<c-l>",
            function() require("zellij-nav").right("move-focus-or-tab") end,
            { silent = true, desc = "navigate right" },
        },
    },
    opts = {},
}
