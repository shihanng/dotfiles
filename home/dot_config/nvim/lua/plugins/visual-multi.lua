return {
    "mg979/vim-visual-multi",
    init = function()
        vim.api.nvim_set_var("VM_default_mappings", 1)
        vim.api.nvim_set_var("VM_set_statusline", 3)

        vim.api.nvim_set_var("VM_maps", {
            ["Find Under"] = "mm",
            ["Find Subword Under"] = "mm",
            ["Undo"] = "u",
            ["Redo"] = "<C-r>",
        })
    end,
}
