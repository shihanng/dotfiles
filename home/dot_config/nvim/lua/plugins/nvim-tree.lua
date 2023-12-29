local function on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    -- Custom mappings.
    vim.keymap.set("n", "[", api.node.navigate.sibling.first, opts("First Sibling"))
    vim.keymap.set("n", "]", api.node.navigate.sibling.last, opts("Last Sibling"))
    vim.keymap.set("n", "K", api.node.show_info_popup, opts("Info"))
end

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("nvim-tree").setup({
            hijack_cursor = true,
            update_focused_file = {
                enable = true,
                ignore_list = {},
            },
            on_attach = on_attach,
            actions = {
                open_file = {
                    quit_on_open = true,
                    window_picker = {
                        enable = false,
                    },
                },
            },
        })

        vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true })
    end,
}
