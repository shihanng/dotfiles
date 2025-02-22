return {
    {
        "echasnovski/mini.nvim",
        version = "*",
        config = function()
            require("mini.ai").setup()
            require("mini.surround").setup()
            require("mini.icons").setup()
            require("mini.files").setup()
            require("mini.align").setup()
            require("mini.pairs").setup()

            vim.keymap.set("n", "-", require("mini.files").open, { desc = "Open parent ectory" })
        end,
    },
}
