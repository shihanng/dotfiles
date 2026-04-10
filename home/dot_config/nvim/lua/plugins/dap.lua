return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "mfussenegger/nvim-dap-python",
            "jbyuki/one-small-step-for-vimkind",
            "theHamsta/nvim-dap-virtual-text",
            "MironPascalCaseFan/debugmaster.nvim",
        },
        config = function()
            local dm = require("debugmaster")
            -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
            -- Alternative keybindings to "<leader>d" could be: "<leader>m", "<leader>;"
            vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
            -- If you want to disable debug mode in addition to leader+d using the Escape key:
            -- vim.keymap.set("n", "<Esc>", dm.mode.disable)
            -- This might be unwanted if you already use Esc for ":noh"
            vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

            dm.plugins.osv_integration.enabled = true -- needed if you want to debug neovim lua code

            local dap = require("dap")
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

            require("dap-python").setup("python")

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

            vim.keymap.set("n", "<Leader>db", function()
                local breakpoints = require("dap.breakpoints").get()
                local items = {}
                for buf, bps in pairs(breakpoints) do
                    local filename = vim.api.nvim_buf_get_name(buf)
                    for _, bp in ipairs(bps) do
                        table.insert(items, {
                            text = filename .. ":" .. bp.line,
                            file = filename,
                            pos = { bp.line, 0 },
                        })
                    end
                end
                Snacks.picker.pick({
                    items = items,
                    format = "file",
                    title = "DAP Breakpoints",
                    confirm = function(picker, item)
                        picker:close()
                        if item then
                            vim.cmd("edit " .. item.file)
                            vim.api.nvim_win_set_cursor(0, { item.pos[1], item.pos[2] })
                        end
                    end,
                })
            end, { noremap = true })

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
