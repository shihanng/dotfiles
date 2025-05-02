return {
    {
        "https://github.com/shihanng/zellij-nav.nvim",
        lazy = true,
        event = "VeryLazy",
        keys = {
            { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>", { silent = true, desc = "navigate left" } },
            { "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" } },
            { "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" } },
            { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right" } },
        },
        opts = {},
    },
    {
        "https://github.com/jpalardy/vim-slime",
        config = function()
            vim.g.slime_target = "zellij"

            -- https://github.com/jpalardy/vim-slime/blob/main/assets/doc/targets/zellij.md#bracketed-paste
            vim.g.slime_bracketed_paste = 1

            vim.keymap.set("n", "<c-c>b", function()
                local cur = vim.g.slime_bracketed_paste or 0
                vim.g.slime_bracketed_paste = cur == 1 and 0 or 1
                print("slime_bracketed_paste=" .. vim.g.slime_bracketed_paste)
            end, { silent = true })
        end,
    },
}
