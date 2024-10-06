return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-nvim-lua",
                "rcarriga/cmp-dap",
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "rafamadriz/friendly-snippets",
                "onsails/lspkind-nvim",
            },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()

            require("luasnip.loaders.from_vscode").lazy_load({
                paths = { "~/.vsnip" },
            })

            cmp.setup({
                sources = {
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "nvim_lua" },
                    { name = "lazydev", group_index = 0 },
                    { name = "buffer" },
                    { name = "path" },
                },
                -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/autocomplete.md#lsp-kind
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = require("lspkind").cmp_format({
                        mode = "symbol", -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters

                        -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                        ellipsis_char = "...",
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ["<CR>"] = cmp.mapping.confirm({
                        select = true,

                        -- luacheck: ignore 631
                        -- documentation says this is important.
                        -- I don't know why.
                        -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/setup-copilot-lua-plus-nvim-cmp.md#setup-copilotlua--nvim-cmp
                        behavior = cmp.ConfirmBehavior.Replace,
                    }),

                    -- Ctrl+Space to trigger completion menu
                    ["<C-e>"] = cmp.mapping.complete(),

                    -- Navigate between snippet placeholder
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),

                    -- Scroll up and down in the completion documentation
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                enabled = function()
                    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
                end,
            })

            cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                sources = {
                    { name = "dap" },
                },
            })
        end,
    },
}
