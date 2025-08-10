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
