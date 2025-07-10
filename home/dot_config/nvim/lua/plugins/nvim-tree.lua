return {
    "lstwn/broot.vim",
    init = function()
        -- Set broot configuration path
        vim.g.broot_default_conf_path = vim.fn.expand("~/.config/broot/conf.hjson")

        -- Optional: Replace netrw with broot
        vim.g.broot_replace_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- Key mappings
        vim.keymap.set("n", "<leader>e", ":BrootWorkingDir<CR>", { silent = true })
        vim.keymap.set("n", "-", ":BrootCurrentDir<CR>", { silent = true })
    end,
}
