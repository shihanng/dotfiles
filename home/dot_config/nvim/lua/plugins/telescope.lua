return {
    "nvim-telescope/telescope-fzy-native.nvim",
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-telescope/telescope-dap.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local actions = require("telescope.actions")

            require("telescope").setup({
                defaults = {
                    file_sorter = require("telescope.sorters").get_fzy_sorter,
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                        },
                    },
                },
                extensions = {
                    fzy_native = {
                        override_generic_sorter = false,
                        override_file_sorter = true,
                    },
                },
            })
            require("telescope").load_extension("fzy_native")
            require("telescope").load_extension("dap")
            require("telescope").load_extension("chezmoi")

            local builtin = require("telescope.builtin")

            -- Setup some Telescope key bindings.
            vim.keymap.set("n", "<Leader>db", require("telescope").extensions.dap.list_breakpoints, { noremap = true })

            -- Spellcheck
            vim.keymap.set("n", "z=", builtin.spell_suggest, { noremap = true })

            -- https://github.com/xvzc/chezmoi.nvim?tab=readme-ov-file#telescope-integration
            vim.keymap.set("n", "<leader>cz", require("telescope").extensions.chezmoi.find_files, {})
        end,
    },
}
