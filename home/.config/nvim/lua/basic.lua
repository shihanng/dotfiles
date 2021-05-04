vim.o.exrc = true
vim.o.hidden = true

vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
vim.o.softtabstop = 4
vim.bo.softtabstop = 4
vim.o.expandtab = true
vim.bo.expandtab = true

vim.o.wrap = false
vim.wo.wrap = false

vim.o.scrolloff = 10
vim.wo.scrolloff = 10

vim.o.relativenumber = true
vim.wo.relativenumber = true
vim.o.number = true
vim.wo.number = true
vim.o.signcolumn = "yes"
vim.wo.signcolumn = "yes"
vim.o.colorcolumn = "80"
vim.wo.colorcolumn = "80"

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.swapfile = false
vim.bo.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.bo.undofile = true
vim.o.undodir = vim.fn.expand("~/.local/share/vim/undo//")

if vim.o.clipboard and #vim.o.clipboard ~= 0 then
    vim.o.clipboard = (vim.o.clipboard .. ',unnamedplus')
else
    vim.o.clipboard = 'unnamedplus'
end
