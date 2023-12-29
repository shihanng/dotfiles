return {
    -- LSP Support
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            "williamboman/mason.nvim",
            'williamboman/mason-lspconfig.nvim',
            "mfussenegger/nvim-dap",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(_, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({
                    buffer = bufnr,
                    exclude = { "<F2>", "gl", "<F3>" },
                })

                local builtin = require("telescope.builtin")

                vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = bufnr })
                vim.keymap.set('n', 'go', builtin.lsp_type_definitions, { buffer = bufnr })
                vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = bufnr })
                vim.keymap.set('n', 'gi', builtin.lsp_implementations, { buffer = bufnr })
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr })
                vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { buffer = bufnr })
                vim.keymap.set('n', '<space>el', builtin.diagnostics, { buffer = bufnr })
            end)

            lsp_zero.set_server_config({
                capabilities = {
                    textDocument = {
                        foldingRange = {
                            -- Setting to integrate with nvim-ufo
                            -- See: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/quick-recipes.md#enable-folds-with-nvim-ufo
                            dynamicRegistration = false,
                            lineFoldingOnly = true
                        }
                    }
                }
            })

            -- Explicitly setup the formatter so that it does not clash with null-ls.
            -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/lsp.md#explicit-setup
            lsp_zero.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ['gopls'] = { 'go' },
                    ['null-ls'] = { 'lua' },
                }
            })

            -- Auto goimports with gopls
            -- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-1128115341
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.go" },
                callback = function()
                    local params = vim.lsp.util.make_range_params()
                    local wait_ms = 500
                    params.context = { only = { "source.organizeImports" } }
                    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
                    for cid, res in pairs(result or {}) do
                        for _, r in pairs(res.result or {}) do
                            if r.edit then
                                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                                vim.lsp.util.apply_workspace_edit(r.edit, enc)
                            end
                        end
                    end
                end,
            })

            local mason = require("mason")
            if not mason.has_setup then
                mason.setup()
            end
            require('mason-lspconfig').setup({
                ensure_installed = { "lua_ls", "gopls" },

                handlers = {
                    lsp_zero.default_setup,
                    ["gopls"] = function()
                        -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md#settings
                        require('lspconfig').gopls.setup({
                            settings = {
                                gopls = {
                                    gofumpt = true,
                                    analyses = {
                                        unusedparams = true,
                                    },
                                    staticcheck = true,
                                    hints = {
                                        assignVariableTypes = true,
                                        compositeLiteralFields = true,
                                        constantValues = true,
                                        functionTypeParameters = true,
                                        parameterNames = true,
                                        rangeVariableTypes = true,
                                    }
                                },
                            }
                        })
                    end,
                    ["lua_ls"] = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls({
                            settings = {
                                Lua = {
                                    hint = {
                                        enable = true,
                                    }
                                }
                            }
                        })
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })

            vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
            vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
            vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
            vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
        end
    }
}