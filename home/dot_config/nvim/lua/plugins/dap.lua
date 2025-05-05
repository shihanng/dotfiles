return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap_ui = require("dapui")
            dap_ui.setup()

            vim.keymap.set("n", "<Leader>dd", dap_ui.toggle)

            local dap = require("dap")
            dap.listeners.after.event_initialized["dapui_config"] = function() dap_ui.open() end
            dap.listeners.before.event_terminated["dapui_config"] = function() dap_ui.close() end
            dap.listeners.before.event_exited["dapui_config"] = function() dap_ui.close() end
        end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "mfussenegger/nvim-dap-python",
            "jbyuki/one-small-step-for-vimkind",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
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

            -- See: https://github.com/mfussenegger/nvim-dap-python?tab=readme-ov-file#debugpy
            --   cd ~/dotfiles
            --   mkdir .virtualenvs
            --   cd .virtualenvs
            --   python -m venv debugpy
            --   debugpy/bin/python -m pip install debugpy
            require("dap-python").setup("~/dotfiles/.virtualenvs/debugpy/bin/python")

            local dap = require("dap")

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

            -- luacheck: ignore 631
            -- Customizing color scheme in dap-ui
            -- https://github.com/rcarriga/nvim-dap-ui/blob/e5c32746aa72e39267803fdf6934d79541d39f42/lua/dapui/config/highlights.lua#L1
            -- https://github.com/rcarriga/nvim-dap-ui/issues/46#issuecomment-899025715
            vim.cmd([[hi! link DapUILineNumber LineNr]])
            vim.cmd([[hi! link DapUIBreakpointsLine LineNr]])
            vim.cmd([[hi! link DapUIBreakpointsCurrentLine LineNr]])

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
