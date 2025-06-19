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
    config = function()
        vim.api.nvim_create_autocmd({ "UIEnter" }, {
            callback = function(_event)
                local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
                if client ~= nil and client.name == "Firenvim" then
                    vim.opt.guifont = "IosevkaTerm Nerd Font:h20"
                    vim.o.laststatus = 0
                end
            end,
        })
    end,
}
