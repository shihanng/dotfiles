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
            },
        },
        keys = {
            {
                "<tab>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>" -- fallback to normal tab
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                "<leader>aa",
                function() require("sidekick.cli").toggle() end,
                mode = { "n", "v" },
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function() require("sidekick.cli").select() end,
                -- Or to select only installed tools:
                -- require("sidekick.cli").select({ filter = { installed = true } })
                desc = "Sidekick Select CLI",
            },
            {
                "<leader>as",
                function() require("sidekick.cli").send({ selection = true }) end,
                mode = { "v" },
                desc = "Sidekick Send Visual Selection",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                mode = { "n", "v" },
                desc = "Sidekick Select Prompt",
            },
            {
                "<c-.>",
                function() require("sidekick.cli").focus() end,
                mode = { "n", "x", "i", "t" },
                desc = "Sidekick Switch Focus",
            },
            -- Example of a keybinding to open Claude directly
            {
                "<leader>ac",
                function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
                desc = "Sidekick Claude Toggle",
                mode = { "n", "v" },
            },
        },
    },
    {
        "NickvanDyke/opencode.nvim",
        dependencies = {
            -- Recommended for better prompt input, and required to use
            -- opencode.nvim's embedded terminal — otherwise optional
            { "folke/snacks.nvim", opts = { input = {}, picker = {} } },
        },
        config = function()
            vim.g.opencode_opts = {
                -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on `opencode_opts`.
                select = {
                    prompts = {
                        commit = "@commit-author, read and improve commit message in @buffer.",
                        proofreader = "@content-proofreader, proofread @this.",
                        pair = "Pair with me in neovim. Connect to " .. require("shihanng.mcp_socket"),
                    },
                },
                lsp = {
                    enabled = false,
                },
            }

            -- Required for `vim.g.opencode_opts.auto_reload`.
            vim.o.autoread = true

            vim.keymap.set(
                { "n", "x" },
                "<leader>oa",
                function() require("opencode").ask("@this: ", { submit = true }) end,
                { desc = "Ask opencode…" }
            )
            vim.keymap.set(
                { "n", "x" },
                "<leader>os",
                function() require("opencode").select() end,
                { desc = "Execute opencode action…" }
            )
            vim.keymap.set(
                { "n", "t" },
                "<leader>ot",
                function() require("opencode").toggle() end,
                { desc = "Toggle opencode" }
            )

            vim.keymap.set(
                { "n", "x" },
                "go",
                function() return require("opencode").operator("@this ") end,
                { desc = "Add range to opencode", expr = true }
            )
            vim.keymap.set(
                "n",
                "goo",
                function() return require("opencode").operator("@this ") .. "_" end,
                { desc = "Add line to opencode", expr = true }
            )

            -- Listen for `opencode` events
            vim.api.nvim_create_autocmd("User", {
                pattern = "OpencodeEvent",
                callback = function(_args)
                    -- See the available event types and their properties
                    -- vim.notify(vim.inspect(args.data.event))
                    -- Do something useful
                    -- if args.data.event.type == "session.idle" then vim.notify("`opencode` finished responding") end
                end,
            })
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
