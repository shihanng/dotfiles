return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
                filetypes = {
                    markdown = true,
                    help = true,
                },
            })
        end,
    },
    {
        "nickjvandyke/opencode.nvim",
        version = "*",
        config = function()
            ---@type opencode.Opts
            vim.g.opencode_opts = {
                select = {
                    prompts = {
                        commit = "@commit-author, read and improve commit message in @buffer.",
                        proofreader = "@content-proofreader, proofread @this.",
                        pair = "Pair with me in neovim. Connect to " .. require("shihanng.mcp_socket"),
                    },
                },
            }

            vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`

            -- Recommended/example keymaps
            vim.keymap.set(
                { "n", "x" },
                "<leader>oa",
                function() require("opencode").ask("@this: ") end,
                { desc = "Ask OpenCode…" }
            )
            vim.keymap.set(
                { "n", "x" },
                "<leader>os",
                function() require("opencode").select() end,
                { desc = "Select OpenCode…" }
            )

            vim.keymap.set(
                { "n", "x" },
                "go",
                function() return require("opencode").operator("@this ") end,
                { desc = "Append range to OpenCode", expr = true }
            )
            vim.keymap.set(
                "n",
                "goo",
                function() return require("opencode").operator("@this ") .. "_" end,
                { desc = "Append line to OpenCode", expr = true }
            )

            vim.keymap.set(
                "n",
                "<S-C-u>",
                function() require("opencode").command("session.half.page.up") end,
                { desc = "Scroll OpenCode up" }
            )
            vim.keymap.set(
                "n",
                "<S-C-d>",
                function() require("opencode").command("session.half.page.down") end,
                { desc = "Scroll OpenCode down" }
            )
        end,
    },
    {
        "linw1995/nvim-mcp",
        config = function()
            local pipe_path = require("shihanng.mcp_socket")

            -- Skip setup if this process is already serving on this socket (e.g.
            -- after a lazy config reload clears the has_setup guard in nvim-mcp).
            -- Otherwise remove any stale socket left by a dead process before binding.
            if not vim.tbl_contains(vim.fn.serverlist(), pipe_path) then
                vim.uv.fs_unlink(pipe_path)
                require("nvim-mcp").setup({ pipe = pipe_path })
            end

            vim.keymap.set(
                "n",
                "<leader>ll",
                function() vim.notify(pipe_path, vim.log.levels.INFO, { title = "Neovim MCP Socket" }) end,
                { desc = "Show Neovim MCP socket path" }
            )
        end,
    },
}
