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
                prompts = {
                    committer = {
                        prompt = "@committer, improve my commit messsage based on what I already have in @this.",
                        submit = true,
                    },
                    grammarly = {
                        prompt = "@grammarly, help me improve @this.",
                        submit = true,
                    },
                },
            }

            -- Required for `vim.g.opencode_opts.auto_reload`.
            vim.o.autoread = true

            -- Recommended/example keymaps.
            vim.keymap.set(
                { "n", "x" },
                "<leader>oa",
                function() require("opencode").ask("@this: ", { submit = true }) end,
                { desc = "Ask about this" }
            )
            vim.keymap.set(
                { "n", "x" },
                "<leader>os",
                function() require("opencode").select() end,
                { desc = "Select prompt" }
            )
            vim.keymap.set(
                { "n", "x" },
                "<leader>o+",
                function() require("opencode").prompt("@this") end,
                { desc = "Add this" }
            )
            vim.keymap.set("n", "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle embedded" })
            vim.keymap.set("n", "<leader>oc", function() require("opencode").command() end, { desc = "Select command" })
            vim.keymap.set(
                "n",
                "<leader>on",
                function() require("opencode").command("session_new") end,
                { desc = "New session" }
            )
            vim.keymap.set(
                "n",
                "<leader>oi",
                function() require("opencode").command("session_interrupt") end,
                { desc = "Interrupt session" }
            )
            vim.keymap.set(
                "n",
                "<leader>oA",
                function() require("opencode").command("agent_cycle") end,
                { desc = "Cycle selected agent" }
            )
            vim.keymap.set(
                "n",
                "<S-C-u>",
                function() require("opencode").command("messages_half_page_up") end,
                { desc = "Messages half page up" }
            )
            vim.keymap.set(
                "n",
                "<S-C-d>",
                function() require("opencode").command("messages_half_page_down") end,
                { desc = "Messages half page down" }
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
}
