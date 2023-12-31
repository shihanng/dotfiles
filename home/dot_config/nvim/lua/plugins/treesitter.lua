return {
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "LiadOz/nvim-dap-repl-highlights",
        },
        config = function()
            require("nvim-treesitter.install").compilers = { "gcc" }

            require("nvim-dap-repl-highlights").setup()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "cue",
                    "dap_repl",
                    "go",
                    "gomod",
                    "gosum",
                    "gowork",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "luadoc",
                    "luap",
                    "python",
                    "requirements",
                    "tsx",
                    "typescript",
                    "vimdoc",
                    "yaml",
                },
                indent = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<c-space>",
                        node_incremental = "<c-space>",
                        scope_incremental = "<c-s>",
                        node_decremental = "<c-backspace>",
                    },
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    disable = { "gitcommit" },
                    highlight = {
                        disable = function()
                            return string.find(vim.bo.filetype, "chezmoitmpl") or vim.bo.filetype == "gitcommit"
                        end,
                    },
                },
                -- https://github.com/windwp/nvim-ts-autotag?tab=readme-ov-file#setup
                autotag = {
                    enable = true,
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                },
            })
        end,
    },
}
