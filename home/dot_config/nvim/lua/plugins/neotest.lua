return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        { "fredrikaverpil/neotest-golang", version = "*" },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-golang"), -- Registration
                require("rustaceanvim.neotest"),
            },
        })
        vim.keymap.set("n", "<leader>tr", function() require("neotest").run.run() end, { noremap = true })
        vim.keymap.set(
            "n",
            "<leader>tt",
            function() require("neotest").run.run(vim.fn.expand("%")) end,
            { noremap = true }
        )
        vim.keymap.set("n", "<leader>tl", function() require("neotest").run.run_last() end, { noremap = true })
        vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end, { noremap = true })
        vim.keymap.set("n", "<leader>to", function() require("neotest").output_panel.toggle() end, { noremap = true })
    end,
}
