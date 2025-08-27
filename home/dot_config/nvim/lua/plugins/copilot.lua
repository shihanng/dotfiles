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
        "copilotlsp-nvim/copilot-lsp",
        init = function()
            require("copilot-lsp").setup({
                nes = {
                    move_count_threshold = 2, -- Clear after 2 movements
                },
            })

            vim.g.copilot_nes_debounce = 500

            vim.keymap.set("n", "<tab>", function()
                local bufnr = vim.api.nvim_get_current_buf()
                local state = vim.b[bufnr].nes_state
                if state then
                    -- Try to jump to the start of the suggestion edit.
                    -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
                    local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
                        or (
                            require("copilot-lsp.nes").apply_pending_nes()
                            and require("copilot-lsp.nes").walk_cursor_end_edit()
                        )
                    return nil
                else
                    -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
                    return "<C-i>"
                end
            end, { desc = "Accept Copilot NES suggestion", expr = true })
        end,
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
