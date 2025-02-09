return {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
        "nvimtools/none-ls-extras.nvim",
        "gbprod/none-ls-luacheck.nvim",
        "gbprod/none-ls-shellcheck.nvim",
    },
    config = function()
        -- Using null-ls as source of truth.
        -- https://github.com/jay-babu/mason-null-ls.nvim?tab=readme-ov-file#primary-source-of-truth-is-null-ls

        local lsp = require("lsp-zero")
        local null_ls = require("null-ls")
        local null_opts = lsp.build_options("null-ls", {})

        local prettierd_filetypes = {
            "css",
            "html",
            "javascript",
            "javascriptreact",
            "json",
            "markdown",
            "markdown.mdx",
            "scss",
            "typescript",
            "typescriptreact",
            "vue",
            "yaml",
        }

        null_ls.setup({
            on_attach = function(client, bufnr) null_opts.on_attach(client, bufnr) end,
            sources = {
                -- List can be found here:
                -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
                require("none-ls.code_actions.eslint_d"),
                require("none-ls.diagnostics.eslint_d"),
                null_ls.builtins.diagnostics.golangci_lint,
                require("none-ls-luacheck.diagnostics.luacheck"),
                null_ls.builtins.formatting.prettierd.with({ filetypes = prettierd_filetypes }),
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.diagnostics.sqlfluff.with({}),
                null_ls.builtins.formatting.sqlfluff.with({}),
                require("none-ls-shellcheck.diagnostics"),
                require("none-ls-shellcheck.code_actions"),
            },
        })

        local mason = require("mason")
        if not mason.has_setup then mason.setup() end
        require("mason-null-ls").setup({
            -- bashls needs shfmt to format.
            ensure_installed = { "shellcheck", "shfmt" },
            automatic_installation = true,
        })
    end,
}
