return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "mfussenegger/nvim-dap-python",
            "jbyuki/one-small-step-for-vimkind",
            "theHamsta/nvim-dap-virtual-text",
            {
                "igorlfs/nvim-dap-view",
                opts = {
                    winbar = {
                        controls = {
                            enabled = true,
                        },
                    },
                    windows = {
                        terminal = {
                            hide = { "go" },
                        },
                    },
                },
            },
        },
        config = function()
            local dap, dv = require("dap"), require("dap-view")
            dap.listeners.before.attach["dap-view-config"] = function() dv.open() end
            dap.listeners.before.launch["dap-view-config"] = function() dv.open() end
            dap.listeners.before.event_terminated["dap-view-config"] = function() dv.close() end
            dap.listeners.before.event_exited["dap-view-config"] = function() dv.close() end

            require("dap-go").setup({
                dap_configurations = {
                    {
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                    },
                },
                delve = {
                    port = "38697",
                },
            })

            require("dap-python").setup("uv")

            -- We need adapters for rustaceanvim.
            -- https://github.com/mrcjkb/rustaceanvim?tab=readme-ov-file#optional
            -- https://github.com/mrcjkb/rustaceanvim/issues/129#issuecomment-1879784810
            dap.adapters.codelldb = {
                type = "executable",
                command = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.11.4/adapter/codelldb",
            }

            dap.adapters.nlua = function(callback, config)
                callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
            end

            dap.configurations.rust = {
                {
                    name = "Attach to process",
                    type = "codelldb",
                    request = "attach",
                    pid = "${command:pickProcess}",
                },
            }

            dap.configurations.lua = {
                {
                    type = "nlua",
                    request = "attach",
                    name = "Attach to running Neovim instance",
                },
            }

            local opts = { noremap = true, silent = true }

            vim.keymap.set("n", "<F1>", dap.step_over, opts)
            vim.keymap.set("n", "<F2>", dap.step_into, opts)
            vim.keymap.set("n", "<F3>", dap.step_out, opts)
            vim.keymap.set("n", "<F5>", dap.continue, opts)
            vim.keymap.set("n", "<F6>", dap.run_to_cursor, opts)
            vim.keymap.set("n", "<F9>", dap.up, opts)
            vim.keymap.set("n", "<F10>", dap.down, opts)
            vim.keymap.set("n", "<Leader>dt", dap.terminate, opts)
            vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, opts)
            vim.keymap.set("n", "<Leader>B", function() dap.set_breakpoint(vim.fn.input("Cond: ")) end, opts)
            vim.keymap.set("n", "<leader>dl", function() require("osv").launch({ port = 8086 }) end, opts)
            vim.keymap.set("n", "<Leader>dd", dv.toggle, opts)

            vim.fn.sign_define(
                "DapBreakpoint",
                { text = "", texthl = "healthSuccess", linehl = "healthSuccess", numhl = "healthSuccess" }
            )
            vim.fn.sign_define(
                "DapBreakpointCondition",
                { text = "", texthl = "healthSuccess", linehl = "healthSuccess", numhl = "healthSuccess" }
            )
            vim.fn.sign_define(
                "DapBreakpointRejected",
                { text = "", texthl = "healthSuccess", linehl = "healthSuccess", numhl = "healthSuccess" }
            )
            vim.fn.sign_define(
                "DapLogPoint",
                { text = "", texthl = "healthWarning", linehl = "healthWarning", numhl = "healthWarning" }
            )
            vim.fn.sign_define(
                "DapStopped",
                { text = "", texthl = "healthError", linehl = "healthError", numhl = "healthError" }
            )

            require("nvim-dap-virtual-text").setup()
        end,
    },
}
