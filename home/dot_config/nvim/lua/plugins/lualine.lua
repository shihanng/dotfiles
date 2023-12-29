return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- Shows vim-visual-multi status in lualine
        local vim_visual_multi = function()
            local vm_status_ok, VMInfos = pcall(vim.fn.VMInfos)
            -- Check if VMInfos exists, check if the return of VMInfos is {}
            if (not vm_status_ok) or (not next(VMInfos)) then
                return ""
            end

            return "V-M " .. VMInfos["status"] .. " " .. VMInfos["ratio"]
        end

        require("lualine").setup({
            options = {
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            extensions = { "nvim-dap-ui", "trouble", "lazy", "fugitive", "quickfix", "nvim-tree" },
            sections = {
                lualine_a = { "mode", vim_visual_multi },
            },
        })
    end,
}
