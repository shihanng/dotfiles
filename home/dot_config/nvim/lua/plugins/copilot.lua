return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
    {
        "copilotlsp-nvim/copilot-lsp",
        init = function()
            vim.g.copilot_nes_debounce = 500
            vim.keymap.set("n", "<tab>", function()
                -- Try to jump to the start of the suggestion edit.
                -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
                local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
                    or (
                        require("copilot-lsp.nes").apply_pending_nes()
                        and require("copilot-lsp.nes").walk_cursor_end_edit()
                    )
            end)
        end,
    },
    {
        {
            "CopilotC-Nvim/CopilotChat.nvim",
            dependencies = {
                "zbirenbaum/copilot.lua",
                { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
            },
            build = "make tiktoken", -- Only on MacOS or Linux
            opts = {
                mappings = {
                    reset = {
                        normal = "<Leader>l",
                        insert = "",
                    },
                },
            },
            -- See Commands section for default commands if you want to lazy load on them
        },
    },
}
