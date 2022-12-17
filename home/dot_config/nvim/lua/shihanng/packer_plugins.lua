local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
end

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	use({ "p00f/nvim-ts-rainbow" })

	-- Aesthetic
	use({ "EdenEast/nightfox.nvim" })
	use({ "hoob3rt/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
	use({ "onsails/lspkind-nvim" })
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use({ "tversteeg/registers.nvim" })
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- Coding
	use({ "neovim/nvim-lspconfig" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "rcarriga/cmp-dap" })
	use({ "hrsh7th/cmp-vsnip" })
	use({ "hrsh7th/vim-vsnip" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	})
	use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
	use({ "RRethy/nvim-treesitter-textsubjects" })
	use({ "windwp/nvim-ts-autotag" })
	use({ "b3nj5m1n/kommentary" })
	use({ "cohama/lexima.vim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({
		"folke/lsp-trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use({ "mbbill/undotree" })
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
	use({ "vim-test/vim-test" })

	-- Debugger
	use({ "mfussenegger/nvim-dap" })
	use({ "rcarriga/nvim-dap-ui" })
	use({ "theHamsta/nvim-dap-virtual-text" })
	-- use({ "leoluz/nvim-dap-go" })
	use({ "shihanng/nvim-dap-go", branch = "attach-remote" })
	use({ "mfussenegger/nvim-dap-python" })

	-- Motion
	use("tpope/vim-surround")
	use({ "christoomey/vim-tmux-navigator" })
	use({ "christoomey/vim-tmux-runner" })
	use({ "jeffkreeftmeijer/vim-numbertoggle" })
	use({ "tpope/vim-repeat" })
	use({ "mg979/vim-visual-multi" })
	use({ "karb94/neoscroll.nvim" })

	-- Explore
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("nvim-telescope/telescope-dap.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use({ "haya14busa/is.vim" })
	use({ "haya14busa/vim-asterisk" })
	use({ "romainl/vim-qf" })
	use({ "yssl/QFEnter" })
	use({
		"luukvbaal/stabilize.nvim",
		config = function()
			require("stabilize").setup()
		end,
	})

	-- Git
	use({ "tpope/vim-fugitive" })
	use({ "tpope/vim-rhubarb" })

	-- Direnv
	use({ "direnv/direnv.vim" })

	-- Markdown
	use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })

	-- Browser
	use({
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})

	-- HTML
	use({ "mattn/emmet-vim" })

	-- Terraform
	use({ "hashivim/vim-terraform" })

	-- Go
	use({ "buoto/gotests-vim" })

	-- Cue
	use({ "jjo/vim-cue" })

	-- SQL
	use({ "nanotee/sqls.nvim" })

	-- chezmoi
	use({ "alker0/chezmoi.vim" })

	-- vim-autosource
	-- Need this plugin to setup local settings per project.
	use("jenterkin/vim-autosource")
end)
