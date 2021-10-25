local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup(
    function(use)
        use "wbthomason/packer.nvim"
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        use {"p00f/nvim-ts-rainbow"}

        -- Aesthetic
        use {"christianchiarulli/nvcode-color-schemes.vim", opt = true, requires = "nvim-treesitter"}
        use {"hoob3rt/lualine.nvim", requires = {"kyazdani42/nvim-web-devicons", opt = true}}
        use {"onsails/lspkind-nvim"}
        use {"lewis6991/gitsigns.nvim", requires = {"nvim-lua/plenary.nvim"}}
        use {"tversteeg/registers.nvim"}

        -- Coding
        use {"neovim/nvim-lspconfig"}
        use {"hrsh7th/cmp-nvim-lsp"}
        use {"hrsh7th/cmp-buffer"}
        use {"hrsh7th/cmp-path"}
        use {"hrsh7th/nvim-cmp"}
        use {"hrsh7th/cmp-vsnip"}
        use {"hrsh7th/vim-vsnip"}
        use {"hrsh7th/cmp-nvim-lua"}

        use {"b3nj5m1n/kommentary"}
        use {"cohama/lexima.vim"}
        use {"JoosepAlviste/nvim-ts-context-commentstring"}
        use {
            "folke/lsp-trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons"
        }
        use {"mbbill/undotree"}
        use {"pierreglaser/folding-nvim"}
        use {"vim-test/vim-test"}

        -- Motion
        use "tpope/vim-surround"
        use {"christoomey/vim-tmux-navigator"}
        use {"christoomey/vim-tmux-runner"}
        use {"jeffkreeftmeijer/vim-numbertoggle"}
        use {"tpope/vim-repeat"}
        use {"mg979/vim-visual-multi"}

        -- Explore
        use {
            "nvim-telescope/telescope.nvim",
            requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
        }
        use "nvim-telescope/telescope-fzy-native.nvim"
        use {
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
        }
        use {"haya14busa/is.vim"}
        use {"haya14busa/vim-asterisk"}
        use {"romainl/vim-qf"}
        use {"yssl/QFEnter"}
        use {
            "luukvbaal/stabilize.nvim",
            config = function()
                require("stabilize").setup()
            end
        }

        -- Git
        use {"tpope/vim-fugitive"}

        -- Direnv
        use {"direnv/direnv.vim"}

        -- Markdown
        use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"}

        -- Browser
        use {
            "glacambre/firenvim",
            run = function()
                vim.fn["firenvim#install"](0)
            end
        }

        -- HTML
        use {"mattn/emmet-vim"}

        -- Terraform
        use {"hashivim/vim-terraform"}

        -- Go
        use {"buoto/gotests-vim"}

        -- Cue
        use {"jjo/vim-cue"}

        -- SQL
        use {"nanotee/sqls.nvim"}

        -- chezmoi
        use {"alker0/chezmoi.vim"}
    end
)
