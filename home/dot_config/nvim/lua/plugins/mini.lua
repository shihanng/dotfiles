return {
    {
        "echasnovski/mini.nvim",
        version = "*",
        config = function()
            local gen_spec = require("mini.ai").gen_spec

            require("mini.ai").setup({
                custom_textobjects = {
                    F = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                    C = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
                    o = gen_spec.treesitter({
                        a = { "@conditional.outer", "@loop.outer" },
                        i = { "@conditional.inner", "@loop.inner" },
                    }),
                },
            })
            require("mini.surround").setup()
            require("mini.icons").setup()
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
        end,
    },
}
