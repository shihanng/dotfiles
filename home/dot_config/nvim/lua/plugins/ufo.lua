return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
        -- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        local ufo = require("ufo")

        -- See: https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#customize-configuration
        local ftMap = {
            -- vim = "indent",
            -- python = { "indent" },
            -- git = "",
        }

        -- See: https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#customize-fold-text
        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = ("  %d "):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, "MoreMsg" })
            return newVirtText
        end

        ufo.setup({
            open_fold_hl_timeout = 150,
            close_fold_kinds = {},
            preview = {
                win_config = {
                    border = { "", "─", "", "", "", "─", "", "" },
                    winhighlight = "Normal:Folded",
                    winblend = 0,
                },
                mappings = {
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                },
            },
            fold_virt_text_handler = handler,
            provider_selector = function(_, filetype, _)
                -- return a string type use internal providers
                -- return a string in a table like a string type
                -- return empty string '' will disable any providers
                -- return `nil` will use default value {'lsp', 'indent'}

                -- if you prefer treesitter provider rather than lsp,
                -- return ftMap[filetype] or {'treesitter', 'indent'}
                return ftMap[filetype]
            end,
        })

        -- Key bindings
        vim.keymap.set("n", "zR", ufo.openAllFolds)
        vim.keymap.set("n", "zM", ufo.closeAllFolds)
        vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
        vim.keymap.set("n", "zm", ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    end,
}
