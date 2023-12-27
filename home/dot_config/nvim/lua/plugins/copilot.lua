return {
	"github/copilot.vim",
	config = function()
		vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)", { noremap = false, silent = true })
		vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", { noremap = false, silent = true })

		vim.g.copilot_filetypes = {
			["*"] = false, -- Disable Copilot globally
			-- We disable Copilot globally,
			-- Use the following to enable for specific language:
			-- ["javascript"] = true, -- Enable for specific filetypes, e.g., JavaScript
		}
	end,
}
