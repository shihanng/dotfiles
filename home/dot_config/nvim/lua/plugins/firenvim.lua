return {
    "glacambre/firenvim",
    build = ":call firenvim#install(0)",
    init = function()
        vim.g.firenvim_config = {
            globalSettings = { alt = "all" },
            localSettings = {
                [".*"] = {
                    selector = "textarea",
                    takeover = "never",
                },
            },
        }
    end,
}
