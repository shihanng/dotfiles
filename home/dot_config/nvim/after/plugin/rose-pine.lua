require("rose-pine").setup({
    dark_variant = "main",
    highlight_groups = {
        ["@text.diff.add"] = { fg = "foam" },
        ["@text.diff.delete"] = { fg = "rose" },
    },
})
vim.cmd.colorscheme("rose-pine")

-- Use color that does have same background color
-- in the LSP diagnostics (the window that shows up during <space>e).
local hi_normal = vim.api.nvim_get_hl_by_name("Normal", true)
vim.api.nvim_set_hl(0, "NormalFloat", hi_normal)
