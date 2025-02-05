return {
    {
        -- https://github.com/alker0/chezmoi.vim?tab=readme-ov-file#-how-can-i-make-it-work-with-lazynvim
        "alker0/chezmoi.vim",
        lazy = false,
        init = function()
            vim.g["chezmoi#use_external"] = true
            vim.g["chezmoi#use_tmp_buffer"] = true
        end,
    },
    {
        "xvzc/chezmoi.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("chezmoi").setup({
                -- your configurations
            })

            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                pattern = { os.getenv("HOME") .. "/dotfiles/home/*" },
                callback = function(ev)
                    local bufnr = ev.buf
                    local edit_watch = function() require("chezmoi.commands.__edit").watch(bufnr) end
                    vim.schedule(edit_watch)
                end,
            })
        end,
    },
}
