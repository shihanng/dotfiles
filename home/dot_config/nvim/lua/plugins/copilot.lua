return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                -- Disable suggestion and panel for blink-cmp-copilot
                suggestion = { enabled = false },
                panel = { enabled = false },
                filetypes = {
                    ["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
                },
            })
        end,
    },
}
