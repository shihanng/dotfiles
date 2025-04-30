return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                -- Disable suggestion and panel for blink-cmp-copilot
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    },
    {
        "copilotlsp-nvim/copilot-lsp",
        init = function() vim.g.copilot_nes_debounce = 500 end,
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
                -- See Configuration section for options
            },
            -- See Commands section for default commands if you want to lazy load on them
        },
    },
}
