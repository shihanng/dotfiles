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
        "olimorris/codecompanion.nvim",
        opts = {},
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        init = function()
            require("codecompanion").setup({
                chat = {
                    opts = {
                        completion_provider = "blink",
                    },
                },
                adapters = {
                    copilot = function()
                        return require("codecompanion.adapters").extend("copilot", {
                            schema = {
                                model = {
                                    default = "claude-sonnet-4",
                                },
                            },
                        })
                    end,
                },
                display = {
                    action_palette = {
                        width = 95,
                        height = 10,
                        prompt = "Prompt ",
                        provider = "snacks",
                        opts = {
                            show_default_actions = true,
                            show_default_prompt_library = true,
                        },
                    },
                },
            })

            vim.keymap.set(
                { "n", "v" },
                "<leader>zc",
                "<cmd>CodeCompanionChat Toggle<cr>",
                { noremap = true, silent = true }
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>za",
                "<cmd>CodeCompanionActions<cr>",
                { noremap = true, silent = true }
            )
        end,
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = {
            preview = {
                filetypes = { "codecompanion" },
                ignore_buftypes = {},
                icon_provider = "mini",
            },
        },
    },
    {
        "echasnovski/mini.diff",
        config = function()
            local diff = require("mini.diff")
            diff.setup({
                -- Disabled by default
                source = diff.gen_source.none(),
            })
        end,
    },
}
