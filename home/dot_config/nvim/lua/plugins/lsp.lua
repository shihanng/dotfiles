return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "minimal",
                transparent_bg = true,

                hi = {
                    background = "None",
                },
            })
            vim.diagnostic.config({ virtual_text = false })
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "mfussenegger/nvim-dap",
            "nanotee/sqls.nvim",
        },
        config = function()
            -- Add borders to floating windows
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
            vim.lsp.handlers["textDocument/signatureHelp"] =
                vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            --
            -- Also support UFO: lsp-zero.netlify.app/docs/guide/quick-recipes.html#enable-folds-with-nvim-ufo
            local lsp_capabilities = vim.tbl_deep_extend("force", require("cmp_nvim_lsp").default_capabilities(), {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            })

            local lspconfig_defaults = require("lspconfig").util.default_config
            lspconfig_defaults.capabilities =
                vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, lsp_capabilities)

            local builtin = require("telescope.builtin")
            local tstools = require("typescript-tools.api")

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gS", vim.lsp.buf.signature_help, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<space>e", builtin.diagnostics, opts)
                    vim.keymap.set("n", "gs", tstools.organize_imports, opts)
                    vim.keymap.set("n", "gI", tstools.add_missing_imports, opts)
                    vim.keymap.set(
                        "n",
                        "<space>h",
                        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(opts)) end,
                        opts
                    )
                end,
            })

            -- Setup rustaceanvim with lsp-zero.
            -- See: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/quick-recipes.md
            vim.g.rustaceanvim = function()
                -- Update this path
                local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
                local codelldb_path = extension_path .. "adapter/codelldb"
                local liblldb_path = extension_path .. "lldb/lib/liblldb"
                local this_os = vim.uv.os_uname().sysname

                -- The path is different on Windows
                if this_os:find("Windows") then
                    codelldb_path = extension_path .. "adapter\\codelldb.exe"
                    liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
                else
                    -- The liblldb extension is .so for Linux and .dylib for MacOS
                    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
                end

                local cfg = require("rustaceanvim.config")
                return {
                    server = {
                        capabilities = lspconfig_defaults.capabilities,
                    },
                    dap = {
                        -- autoload_configurations = true,
                        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
                    },
                }
            end

            -- Auto goimports with gopls
            -- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-1128115341
            -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
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

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp_attach_server_caps", { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client == nil then return end
                    if client.name == "ruff" then
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end

                    if client.name == "yamlls" then
                        -- Need this so that conform uses LSP to format yaml.* files.
                        client.server_capabilities.documentFormattingProvider = true
                    end
                end,
                desc = "LSP: Disable hover capability from Ruff",
            })

            -- Ref: https://lsp-zero.netlify.app/docs/guide/integrate-with-mason-nvim
            local noop = function() end
            local mason = require("mason")
            if not mason.has_setup then mason.setup() end
            require("mason-lspconfig").setup({
                automatic_installation = false,
                ensure_installed = {},

                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name) require("lspconfig")[server_name].setup({}) end,
                    -- https://lsp-zero.netlify.app/docs/guide/neovim-lua-ls
                    ["rust_analyzer"] = noop,
                    ["ts_ls"] = noop,
                    ["lua_ls"] = function()
                        require("lspconfig").lua_ls.setup({
                            settings = {
                                Lua = {
                                    telemetry = {
                                        enable = false,
                                    },
                                },
                            },
                            on_init = function(client)
                                local join = vim.fs.joinpath
                                local path = client.workspace_folders[1].name

                                -- Don't do anything if there is project local config
                                if
                                    vim.uv.fs_stat(join(path, ".luarc.json"))
                                    or vim.uv.fs_stat(join(path, ".luarc.jsonc"))
                                then
                                    return
                                end

                                -- Apply neovim specific settings
                                local runtime_path = vim.split(package.path, ";")
                                table.insert(runtime_path, join("lua", "?.lua"))
                                table.insert(runtime_path, join("lua", "?", "init.lua"))

                                local nvim_settings = {
                                    runtime = {
                                        -- Tell the language server which version of Lua you're using
                                        version = "LuaJIT",
                                        path = runtime_path,
                                    },
                                    diagnostics = {
                                        -- Get the language server to recognize the `vim` global
                                        globals = { "vim" },
                                    },
                                    workspace = {
                                        checkThirdParty = false,
                                        library = {
                                            -- Make the server aware of Neovim runtime files
                                            vim.env.VIMRUNTIME,
                                            vim.fn.stdpath("config"),
                                        },
                                    },
                                }

                                client.config.settings.Lua =
                                    vim.tbl_deep_extend("force", client.config.settings.Lua, nvim_settings)
                            end,
                        })
                    end,
                    ["gopls"] = function()
                        -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md#settings
                        require("lspconfig").gopls.setup({
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
                                    },
                                },
                            },
                        })
                    end,
                    ["yamlls"] = function()
                        require("lspconfig").yamlls.setup({
                            settings = {
                                yaml = {
                                    format = {
                                        enable = true,
                                    },
                                    schemas = {
                                        -- luacheck: no max line length
                                        ["https://json.schemastore.org/pre-commit-config.json"] = ".pre-commit-config.yaml",
                                        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                                    },
                                },
                            },
                            filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.github" },
                        })
                    end,
                    ["bashls"] = function()
                        require("lspconfig").bashls.setup({
                            filetypes = { "bash", "sh" },
                            settings = {
                                bashIde = {
                                    globPattern = "*@(.sh|.inc|.bash|.command)",
                                },
                            },
                        })
                    end,
                    ["sqls"] = function()
                        require("lspconfig").sqls.setup({
                            on_attach = function(client, bufnr) require("sqls").on_attach(client, bufnr) end,
                        })
                    end,
                    ["basedpyright"] = function()
                        require("lspconfig").basedpyright.setup({
                            settings = {
                                basedpyright = {
                                    disableOrganizeImports = true,
                                    analysis = {
                                        diagnosticMode = "openFilesOnly",
                                        inlayHints = {
                                            callArgumentNames = true,
                                        },
                                    },
                                },
                            },
                        })
                    end,
                    ["tflint"] = function()
                        require("lspconfig").tflint.setup({
                            root_dir = require("lspconfig").util.root_pattern(".git", ".tflint.hcl"),
                        })
                    end,
                    ["astro"] = function() require("lspconfig").astro.setup({}) end,
                },
            })

            -- https://lsp-zero.netlify.app/docs/language-server-configuration.html#diagnostics
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰀩",
                        [vim.diagnostic.severity.WARN] = "󰀦",
                        [vim.diagnostic.severity.HINT] = "󱜺",
                        [vim.diagnostic.severity.INFO] = "󰋼",
                    },
                },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "<leader>f",
                function() require("conform").format({ async = true }) end,
                mode = "",
                desc = "Format buffer",
            },
        },
        -- This will provide type hinting with LuaLS
        ---@module "conform"
        ---@type conform.setupOpts
        opts = {
            formatters_by_ft = {
                go = { lsp_format = "first" },
                lua = { "stylua" },
                python = { lsp_format = "first" },
                rust = { lsp_format = "first" },
                sh = { lsp_format = "first" },
                sql = { "sqlfluff" },
                terraform = { lsp_format = "first" },
                toml = { lsp_format = "first" },
                yaml = { lsp_format = "first" },

                json = { "prettierd" },
                html = { "prettierd" },
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                markdown = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
            },
            default_format_opts = {
                lsp_format = "never",
            },
            format_on_save = { timeout_ms = 500 },
            formatters = {},
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                ["go"] = { "golangcilint" },
                ["lua"] = { "selene" },
                ["sql"] = { "sqlfluff" },
                ["yaml.github"] = { "actionlint" },

                ["javascript"] = { "eslint_d" },
                ["javascriptreact"] = { "eslint_d" },
                ["typescript"] = { "eslint_d" },
                ["typescriptreact"] = { "eslint_d" },
            }

            require("lint").linters.sqlfluff.args = {
                "lint",
                "--format=json",
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function() lint.try_lint() end,
            })
        end,
    },
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
            { "kosayoda/nvim-lightbulb" },
        },
        event = "LspAttach",
        config = function()
            require("tiny-code-action").setup()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true },
            })
            vim.keymap.set(
                "n",
                "<leader>ca",
                function() require("tiny-code-action").code_action() end,
                { noremap = true, silent = true }
            )
        end,
    },
}
