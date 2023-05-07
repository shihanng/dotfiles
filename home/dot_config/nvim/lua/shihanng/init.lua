local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
vim.opt.termguicolors = true
vim.g.mapleader = ","
vim.opt.shell = "/bin/bash"

require("lazy").setup("plugins")

require("shihanng.basic")
require("shihanng.remap")
require("shihanng.motion")
require("shihanng.aesthetic")
require("shihanng.explore")
require("shihanng.format")
require("shihanng.spell")
require("shihanng.browser")
require("shihanng.test")
require("shihanng.quickfix")
require("shihanng.git")
require("shihanng.git_wp")
require("shihanng.tf")
