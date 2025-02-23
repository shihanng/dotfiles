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
            require("mini.comment").setup({
                options = {
                    custom_commentstring = function()
                        -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#minicomment
                        -- See comment.lua
                        return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
                    end,
                },
            })

            vim.keymap.set("n", "-", require("mini.files").open, { desc = "Open parent ectory" })
        end,
    },
}
