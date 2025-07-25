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
                model = "claude-sonnet-4",
                mappings = {
                    reset = {
                        normal = "<Leader>l",
                        insert = "",
                    },
                },
            },
            keys = {
                { "<leader>zc", ":CopilotChat<CR>", mode = { "n", "v" }, desc = "Chat with Copilot" },
                { "<leader>ze", ":CopilotChatExplain<CR>", mode = { "v" }, desc = "Explain code" },
                { "<leader>zr", ":CopilotChatReview<CR>", mode = { "v" }, desc = "Review code" },
                { "<leader>zf", ":CopilotChatFix<CR>", mode = { "v" }, desc = "Fix code" },
                { "<leader>zo", ":CopilotChatOptimize<CR>", mode = { "v" }, desc = "Optimize code" },
                { "<leader>zd", ":CopilotChatDocs<CR>", mode = { "v" }, desc = "Document code" },
                { "<leader>zt", ":CopilotChatTests<CR>", mode = { "v" }, desc = "Generate test for code" },
                {
                    "<leader>zm",
                    ":CopilotChatCommit<CR>",
                    mode = { "n", "v" },
                    desc = "Generate commit message for code",
                },
            },
        },
    },
}
