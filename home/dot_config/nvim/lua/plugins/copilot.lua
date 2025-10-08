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
            { "folke/snacks.nvim", opts = { input = { enabled = true } } },
        },
        ---@type opencode.Opts
        opts = {
            -- Your configuration, if any — see lua/opencode/config.lua
        },
        keys = {
            -- Recommended keymaps
            { "<leader>oA", function() require("opencode").ask() end, desc = "Ask opencode" },
            {
                "<leader>oa",
                function() require("opencode").ask("@cursor: ") end,
                desc = "Ask opencode about this",
                mode = "n",
            },
            {
                "<leader>oa",
                function() require("opencode").ask("@selection: ") end,
                desc = "Ask opencode about selection",
                mode = "v",
            },
            { "<leader>ot", function() require("opencode").toggle() end, desc = "Toggle embedded opencode" },
            { "<leader>on", function() require("opencode").command("session_new") end, desc = "New session" },
            { "<leader>oy", function() require("opencode").command("messages_copy") end, desc = "Copy last message" },
            {
                "<S-C-u>",
                function() require("opencode").command("messages_half_page_up") end,
                desc = "Scroll messages up",
            },
            {
                "<S-C-d>",
                function() require("opencode").command("messages_half_page_down") end,
                desc = "Scroll messages down",
            },
            {
                "<leader>op",
                function() require("opencode").select_prompt() end,
                desc = "Select prompt",
                mode = { "n", "v" },
            },
            {
                "<leader>oe",
                function() require("opencode").prompt("Explain @cursor and its context") end,
                desc = "Explain code near cursor",
            },
        },
        config = function()
            -- Listen for opencode events
            vim.api.nvim_create_autocmd("User", {
                pattern = "OpencodeEvent",
                callback = function(args)
                    -- Show notification when opencode finishes responding
                    if args.data.type == "session.idle" then
                        vim.notify("opencode finished responding", vim.log.levels.INFO)
                    end
                end,
            })
        end,
    },
}
