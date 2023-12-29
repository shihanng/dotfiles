return {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
    },
    config = function()
        -- Using null-ls as source of truth.
        -- https://github.com/jay-babu/mason-null-ls.nvim?tab=readme-ov-file#primary-source-of-truth-is-null-ls

        local lsp = require('lsp-zero')
        local null_ls = require('null-ls')
        local null_opts = lsp.build_options('null-ls', {})

        null_ls.setup({
            on_attach = function(client, bufnr)
                null_opts.on_attach(client, bufnr)
            end,
            sources = {
                -- List can be found here:
                -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
                null_ls.builtins.diagnostics.golangci_lint,
                null_ls.builtins.formatting.stylua,
            },
        })

        local mason = require("mason")
        if not mason.has_setup then
            mason.setup()
        end
        require("mason-null-ls").setup({
            ensure_installed = nil,
            automatic_installation = true,
        })
    end,
}
