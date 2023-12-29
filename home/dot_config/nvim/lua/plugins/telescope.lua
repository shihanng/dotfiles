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
            local trouble = require("trouble.providers.telescope")

            require("telescope").setup({
                defaults = {
                    file_sorter = require("telescope.sorters").get_fzy_sorter,
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<c-t>"] = trouble.open_with_trouble,
                        },
                        n = { ["<c-t>"] = trouble.open_with_trouble },
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

            local builtin = require("telescope.builtin")

            -- Setup some Telescope key bindings.
            vim.keymap.set("n", "<C-f>", builtin.live_grep, { noremap = true })
            vim.keymap.set("n", "<C-b>", function()
                builtin.buffers({ show_all_buffers = true })
            end, { noremap = true })
            vim.keymap.set("n", "<Leader>db", require("telescope").extensions.dap.list_breakpoints, { noremap = true })

            -- We cache the results of "git rev-parse"
            -- Process creation is expensive in Windows, so this reduces latency
            local is_inside_work_tree = {}

            vim.keymap.set("n", "<C-p>", function()
                -- luacheck: ignore 631
                -- Fallback to find_files if not in git directory.
                -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory

                local cwd = vim.fn.getcwd()
                if is_inside_work_tree[cwd] == nil then
                    vim.fn.system("git rev-parse --is-inside-work-tree")
                    is_inside_work_tree[cwd] = vim.v.shell_error == 0
                end

                if is_inside_work_tree[cwd] then
                    builtin.git_files({ show_untracked = true })
                else
                    builtin.find_files()
                end
            end, { noremap = true })

            -- Spellcheck
            vim.keymap.set("n", "z=", builtin.spell_suggest, { noremap = true })
        end,
    },
}
