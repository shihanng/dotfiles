require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    -- background = { -- :h background
    -- 	light = "macchiato",
    -- 	dark = "macchiato",
    -- },
    integrations = {
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
            },
            underlines = {
                errors = {},
                hints = { "underline" },
                warnings = {},
                information = { "underline" },
                ok = { "underline" },
            },
            inlay_hints = {
                background = false,
            },
        },
        snacks = {
            enabled = true,
            indent_scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
        },
    },
})

vim.cmd.colorscheme("catppuccin")
