require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    -- background = { -- :h background
    -- 	light = "macchiato",
    -- 	dark = "macchiato",
    -- },
})

vim.cmd.colorscheme("catppuccin")
local current = vim.api.nvim_get_hl_by_name("LspInlayHint", true)
current.bg = "none"
vim.api.nvim_set_hl(0, "LspInlayHint", current)
