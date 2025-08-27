return {
    {
        "sindrets/diffview.nvim",
        config = function()
            require("diffview").setup({})

            vim.keymap.set("n", "<leader>gd", [[:DiffviewOpen <CR>]], { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>gx", [[:DiffviewClose <CR>]], { noremap = true, silent = true })
        end,
    },
    {
        "julienvincent/hunk.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        cmd = { "DiffEditor" },
        config = function() require("hunk").setup() end,
    },
    { "avm99963/vim-jjdescription" },
    { "rafikdraoui/jj-diffconflicts" },
}
