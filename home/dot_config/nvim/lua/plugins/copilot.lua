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
                -- Custom Zellij provider
                provider = {
                    cmd = "opencode --port",
                    pane_name = nil, -- Track the pane name

                    -- Health check: verify zellij is available and we're in a session
                    health = function()
                        if vim.fn.executable("zellij") ~= 1 then
                            return "`zellij` executable not found in `$PATH`.",
                                {
                                    "Install `zellij` and ensure it's in your `$PATH`.",
                                }
                        end
                        if not vim.env.ZELLIJ then
                            return "Not running inside a `zellij` session.",
                                {
                                    "Launch Neovim inside a `zellij` session.",
                                }
                        end
                        return true
                    end,

                    -- Start OpenCode in a new Zellij pane
                    start = function(self)
                        if not self.pane_name then
                            self.pane_name = "opencode_" .. vim.fn.getpid()

                            vim.fn.system({
                                "zellij",
                                "action",
                                "new-pane",
                                "--name=" .. vim.fn.shellescape(self.pane_name),
                                "--direction=right",
                                "--close-on-exit",
                                "--",
                                "zsh",
                                "-i",
                                "-c",
                                self.cmd,
                            })
                            vim.fn.system({
                                "zellij",
                                "action",
                                "focus-previous-pane",
                            })
                        end
                    end,

                    -- Toggle does not do anything
                    toggle = function(_self) end,

                    -- Stop does not do anything
                    stop = function(_self) end,
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
}
