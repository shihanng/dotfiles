-- https://github.com/mrcjkb/rustaceanvim?tab=readme-ov-file#zap-quick-setup
local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>ca", function()
    vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
end, { silent = true, buffer = bufnr, desc = "Code Action for Rust" })
