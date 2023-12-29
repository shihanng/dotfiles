return {
    "tversteeg/registers.nvim",
    name = "registers",
    keys = {
        { '"', mode = { "n", "v" } },
        { "<C-R>", mode = "i" },
    },
    cmd = "Registers",
    config = function()
        require("registers").setup({
            window = {
                border = "rounded",
            },
        })
    end,
}
