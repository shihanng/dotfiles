return {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
        require("typescript-tools").setup({
            settings = {
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = "all",
                },
            },
            -- Using Prettier to format codes.
            on_attach = function(client, _)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        })
    end,
}
