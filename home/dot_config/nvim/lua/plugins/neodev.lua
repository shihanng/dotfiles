return {
    "folke/neodev.nvim",
    opts = {},
    config = function()
        require("neodev").setup({
            library = {
                plugins = {
                    "neotest",
                    "nvim-dap-ui",
                },
                types = true,
            },
        })
    end,
}
