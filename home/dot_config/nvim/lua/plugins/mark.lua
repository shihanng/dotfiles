return {
    "shihanng/recall.nvim",
    branch = "snacks-picker",
    config = function()
        local recall = require("recall")

        recall.setup({
            sign = "",
            sign_highlight = "@label",

            snacks = {
                mappings = {
                    unmark_selected_entry = {
                        insert = "<C-d>",
                    },
                },
            },
        })

        vim.keymap.set("n", "<leader>mm", recall.toggle, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>mn", recall.goto_next, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>mp", recall.goto_prev, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>mc", recall.clear, { noremap = true, silent = true })
        vim.keymap.set("n", "<C-m>", require("recall.snacks").pick, { noremap = true, silent = true })
    end,
}
