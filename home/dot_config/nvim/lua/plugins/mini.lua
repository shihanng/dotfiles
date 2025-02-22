return {
    {
        "echasnovski/mini.ai",
        version = "*",
        config = function() require("mini.ai").setup() end,
    },
    {
        "echasnovski/mini.surround",
        version = "*",
        config = function() require("mini.surround").setup() end,
    },
    {
        "echasnovski/mini.icons",
        version = "*",
        config = function() require("mini.icons").setup() end,
    },
    {
        "echasnovski/mini.files",
        version = "*",
        config = function()
            require("mini.files").setup()

            vim.keymap.set("n", "-", require("mini.files").open, { desc = "Open parent ectory" })
        end,
    },
}
