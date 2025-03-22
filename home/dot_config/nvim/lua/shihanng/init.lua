-- Disable netrw as recommended by nvim-tree.
-- See: https://github.com/nvim-tree/nvim-tree.lua?tab=readme-ov-file#setup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Basic Neovim setup.
vim.opt.termguicolors = true
vim.g.mapleader = ","
vim.opt.shell = "/bin/bash"
vim.opt.syntax = "on"

-- Find and replace (by Nick Janetakis)
vim.api.nvim_set_keymap("n", "<Leader>rr", [[:%s///g<Left><Left>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>rc", [[:%s///gc<Left><Left><Left>]], { noremap = true })
vim.api.nvim_set_keymap("x", "<Leader>rr", [[:s///g<Left><Left>]], { noremap = true })
vim.api.nvim_set_keymap("x", "<Leader>rc", [[:s///gc<Left><Left><Left>]], { noremap = true })

-- Setup lazy.nvim.
-- Auto-install lazy.nvim if not present.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

if not uv.fs_stat(lazypath) then
    print("Installing lazy.nvim....")
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
    print("Done.")
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- More basic Neovim setup
vim.opt.exrc = true
vim.opt.hidden = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.scrolloff = 10

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = "yes:2" -- Reserve space for diagnostic icons
vim.opt.colorcolumn = "80"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.local/share/vim/undo//")

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.clipboard = "unnamedplus"
vim.g.do_filetype_lua = 1
vim.o.splitkeep = "screen" -- https://github.com/luukvbaal/stabilize.nvim

-- Other key bindings
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.api.nvim_set_keymap("", "<Leader>pg", [[:%!pg_format -L - <cr>]], { noremap = true })
vim.api.nvim_set_keymap("", "<Leader>jq", [[:%!jq '.'<cr>]], { noremap = true })

-- Spellcheck
vim.opt.spelllang = { "en", "cjk" }
vim.api.nvim_set_keymap("n", "<Leader>s", [[:set spell!<CR>]], { silent = true }) -- Toggle spell checking on and off.

-- Git
vim.api.nvim_set_keymap("n", "<leader>gs", [[:G<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>g]", [[:diffget //3<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>g[", [[:diffget //2<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>gd", [[:Gvdiff!<CR>]], {})

vim.cmd([[ command! -nargs=1 Browse silent exec '!open "<args>"' ]])

vim.api.nvim_set_keymap("n", "<leader>cp", [[:let @+ = expand('%:p')<CR>]], {})

-- pip install pynvim in global mise python
vim.g.python3_host_prog = "$HOME/.local/share/mise/installs/python/latest/bin/python"
