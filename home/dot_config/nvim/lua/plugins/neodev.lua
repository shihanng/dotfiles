return {
	"folke/neodev.nvim",
	opts = {},
	config = function()
		require("neodev").setup({
			library = { plugins = { "neotest" }, types = true },
		})
	end,
}
