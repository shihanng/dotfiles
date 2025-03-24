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
        },
    },
})

vim.cmd.colorscheme("catppuccin")
local current = vim.api.nvim_get_hl_by_name("LspInlayHint", true)
current.bg = "none"
vim.api.nvim_set_hl(0, "LspInlayHint", current)
