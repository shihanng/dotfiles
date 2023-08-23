return {
	"github/copilot.vim",
	config = function()
		vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)", { noremap = false, silent = true })
		vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", { noremap = false, silent = true })
	end,
}
