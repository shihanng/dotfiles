return {
    "davidmh/mdx.nvim",
    "LiadOz/nvim-dap-repl-highlights",
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    -- Defaults
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = false, -- Auto close on trailing </
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        init = function()
            require("nvim-dap-repl-highlights").setup()

            require("nvim-treesitter.install").compilers = { "gcc" }
            require("nvim-treesitter").install({
                "astro",
                "bash",
                "css",
                "cue",
                "dap_repl",
                "diff",
                "git_rebase",
                "go",
                "gomod",
                "gosum",
                "gowork",
                "hcl",
                "html",
                "javascript",
                "json",
                "jsonnet",
                "just",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "regex",
                "requirements",
                "rust",
                "terraform",
                "tsx",
                "typescript",
                "vimdoc",
                "yaml",
            })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    if string.find(vim.bo.filetype, "chezmoitmpl") then return end

                    -- Enable treesitter highlighting and disable regex syntax
                    pcall(vim.treesitter.start)
                    -- Enable treesitter-based indentation
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
