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
            require("mini.files").setup()
        end,
        init = function()
            local minifiles_toggle = function(...)
                if not MiniFiles.close() then MiniFiles.open(...) end
            end

            vim.keymap.set("n", "<C-n>", minifiles_toggle, { silent = true })

            local map_split = function(buf_id, lhs, direction)
                local rhs = function()
                    -- Make new window and set it as target
                    local cur_target = MiniFiles.get_explorer_state().target_window
                    local new_target = vim.api.nvim_win_call(cur_target, function()
                        vim.cmd(direction .. " split")
                        return vim.api.nvim_get_current_win()
                    end)

                    MiniFiles.set_target_window(new_target)

                    -- This intentionally doesn't act on file under cursor in favor of
                    -- explicit "go in" action (`l` / `L`). To immediately open file,
                    -- add appropriate `MiniFiles.go_in()` call instead of this comment.
                end

                -- Adding `desc` will result into `show_help` entries
                local desc = "Split " .. direction
                vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Tweak keys to your liking
                    map_split(buf_id, "<C-s>", "belowright horizontal")
                    map_split(buf_id, "<C-v>", "belowright vertical")
                    map_split(buf_id, "<C-t>", "tab")
                end,
            })
        end,
    },
}
