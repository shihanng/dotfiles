local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup(
    function()
    use 'wbthomason/packer.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'christianchiarulli/nvcode-color-schemes.vim', opt =true, requires = 'nvim-treesitter'}
    use { 'neovim/nvim-lspconfig'}
    end
)
