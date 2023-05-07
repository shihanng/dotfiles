local t = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "350", [['sine']] } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "350", [['sine']] } }
t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
t["zt"] = { "zt", { "250" } }
t["zz"] = { "zz", { "250" } }
t["zb"] = { "zb", { "250" } }

return {
	"karb94/neoscroll.nvim",
	config = function()
		require("neoscroll").setup({
			mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
			easing_function = "quadratic",
			stop_eof = true,
		})
		require("neoscroll.config").set_mappings(t)
	end,
}
