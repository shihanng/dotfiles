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
        "folke/sidekick.nvim",
        opts = {
            -- add any options here
            nes = { enabled = false },
            cli = {
                mux = {
                    backend = "zellij",
                    enabled = true,
                },
                prompts = {
                    commit = "@commit-author, read and improve commit message in {file}.",
                    proofreader = "@content-proofreader, proofread {this}.",
                    pair = "Pair with me in neovim. Connect to " .. require("shihanng.mcp_socket"),
                },
            },
        },
        keys = {
            {
                "<leader>as",
                function() require("sidekick.cli").select({ filter = { installed = true } }) end,
                desc = "Select CLI",
            },
            {
                "<leader>at",
                function() require("sidekick.cli").send({ msg = "{this}" }) end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function() require("sidekick.cli").send({ msg = "{file}" }) end,
                desc = "Send File",
            },
            {
                "<leader>av",
                function() require("sidekick.cli").send({ msg = "{selection}" }) end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                mode = { "n", "x" },
                desc = "Sidekick Select Prompt",
            },
        },
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
