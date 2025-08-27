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
                    diff = {
                        enabled = true,
                        -- Close an open chat buffer if the total columns of your display are less than...
                        close_chat_at = 240,
                        layout = "vertical",
                        opts = {
                            "internal",
                            "filler",
                            "closeoff",
                            "algorithm:patience",
                            "followwrap",
                            "linematch:120",
                        },
                        provider = "default", -- default|mini_diff
                    },
                },
                extensions = {
                    vectorcode = {
                        ---@type VectorCode.CodeCompanion.ExtensionOpts
                        opts = {
                            tool_group = {
                                enabled = true,
                                extras = { "file_search" },
                                collapse = false,
                            },
                        },
                    },
                    mcphub = {
                        callback = "mcphub.extensions.codecompanion",
                        opts = {
                            -- MCP Tools
                            -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
                            make_tools = true,

                            -- Show individual tools in chat completion (when make_tools=true)
                            show_server_tools_in_chat = true,

                            -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
                            add_mcp_prefix_to_tool_names = false,

                            -- Show tool results directly in chat buffer
                            show_result_in_chat = true,

                            -- Function to format tool names to show in the chat buffer
                            -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string
                            format_tool = nil,

                            -- MCP Resources
                            make_vars = true, -- Convert MCP resources to #variables for prompts
                            -- MCP Prompts
                            make_slash_commands = true, -- Add MCP prompts as /slash commands
                        },
                    },
                },
            })

            require("shihanng.fidget-spinner"):init()

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
    {
        "Davidyz/VectorCode",
        version = "*", -- optional, depending on whether you're on nightly or release
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "VectorCode", -- if you're lazy-loading VectorCode
        init = function()
            require("vectorcode").setup({
                async_backend = "lsp",
            })
        end,
    },
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "",
        config = function() require("mcphub").setup() end,
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
