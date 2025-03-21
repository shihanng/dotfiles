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
            require("mini.jump").setup()

            vim.keymap.set(
                "n",
                "-",
                "<CMD>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>",
                { desc = "Open parent directory" }
            )

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesActionRename",
                callback = function(event) Snacks.rename.on_rename_file(event.data.from, event.data.to) end,
            })
        end,
    },
}
