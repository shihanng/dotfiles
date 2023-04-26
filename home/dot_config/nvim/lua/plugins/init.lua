return {
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-treesitter/playground",

	"p00f/nvim-ts-rainbow",

	-- Aesthetic
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "hoob3rt/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },
	"onsails/lspkind-nvim",
	{ "lewis6991/gitsigns.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	"tversteeg/registers.nvim",
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"simrat39/inlay-hints.nvim",
		config = function()
			require("inlay-hints").setup({
				only_current_line = false,
				eol = {
					right_align = true,
				},
			})
		end,
	},

	-- Coding
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "jayp0521/mason-null-ls.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
	"rcarriga/cmp-dap",
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	},
	"jose-elias-alvarez/typescript.nvim",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"windwp/nvim-ts-autotag",
	"cohama/lexima.vim",
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"folke/lsp-trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("trouble").setup({})
		end,
	},
	"mbbill/undotree",
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
	"vim-test/vim-test",
	"johmsalas/text-case.nvim",

	-- Debugger
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",
	"leoluz/nvim-dap-go",
	"mfussenegger/nvim-dap-python",
	"jayp0521/mason-nvim-dap.nvim",

	-- Motion
	"tpope/vim-surround",
	"christoomey/vim-tmux-navigator",
	"christoomey/vim-tmux-runner",
	"jeffkreeftmeijer/vim-numbertoggle",
	"tpope/vim-repeat",
	"mg979/vim-visual-multi",
	"karb94/neoscroll.nvim",
	"junegunn/vim-easy-align",

	-- Explore
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	"nvim-telescope/telescope-dap.nvim",
	"nvim-telescope/telescope-fzy-native.nvim",
	"haya14busa/is.vim",
	"haya14busa/vim-asterisk",
	"romainl/vim-qf",
	"yssl/QFEnter",
	{
		"luukvbaal/stabilize.nvim",
		config = function()
			require("stabilize").setup()
		end,
	},
	"ThePrimeagen/harpoon",

	-- Git
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Direnv
	"direnv/direnv.vim",

	-- Markdown
	{ "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },

	-- Browser
	{
		"glacambre/firenvim",
		build = function()
			vim.fn["firenvim#install"](0)
		end,
	},

	-- HTML
	"mattn/emmet-vim",

	-- Terraform
	"hashivim/vim-terraform",

	-- Go
	"buoto/gotests-vim",

	-- Cue
	"jjo/vim-cue",

	-- chezmoi
	"alker0/chezmoi.vim",

	-- vim-autosource
	-- Need this plugin to setup local settings per project.
	"jenterkin/vim-autosource",
}
