require "nvim-treesitter.configs".setup {
    ensure_installed = "all",
    highlight = {
        enable = true
    }
}

vim.g.nvcode_termcolors = 256

vim.o.syntax = "on"
vim.bo.syntax = "on"

vim.cmd([[colorscheme nord]])

if vim.fn.has("termguicolors") == 1 then
    vim.o.termguicolors = true
end

require "lualine".setup {
    options = {theme = "nord"}
}
