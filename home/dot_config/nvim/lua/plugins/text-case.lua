-- https://github.com/johmsalas/text-case.nvim?tab=readme-ov-file#example-for-lazyvim
return {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    -- Author's Note: If default keymappings fail to register (possible config issue in my local setup),
    -- verify lazy loading functionality. On failure, disable lazy load and report issue
    -- lazy = false,
    config = function()
        require("textcase").setup({})
        require("telescope").load_extension("textcase")
    end,
    keys = {
        { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
    },
}
