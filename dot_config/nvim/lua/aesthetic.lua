require "nvim-treesitter.configs".setup {
    ensure_installed = "all",
    ignore_install = {"haskell"},
    indent = {
        enable = true
    },
    highlight = {
        enable = true
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false
    }
}

vim.g.nvcode_termcolors = 256

vim.opt.syntax = "on"

vim.cmd([[colorscheme nord]])

if vim.fn.has("termguicolors") == 1 then
    vim.opt.termguicolors = true
end

require "lualine".setup {
    options = {theme = "nord"}
}

require("lspkind").init({})
require("gitsigns").setup()

vim.api.nvim_set_keymap(
    "n",
    "<Leader>ch",
    [[:center 80<cr>hhv0r=A<space><esc>40A=<esc>:Commentary<cr><esc>81<bar>D]],
    {silent = true}
)
