return {
    {
        "nvim-mini/mini.nvim",
        version = "*",
        config = function()
            local gen_spec = require("mini.ai").gen_spec

            require("mini.ai").setup({
                custom_textobjects = {
                    F = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                    C = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
                    o = gen_spec.treesitter({
                        a = { "@conditional.outer", "@loop.outer" },
                        i = { "@conditional.inner", "@loop.inner" },
                    }),
                },
            })
            require("mini.surround").setup()
            require("mini.icons").setup()
            require("mini.align").setup()
            require("mini.pairs").setup()
            require("mini.comment").setup()

            -- <leader>ch: turn the current line into a centered comment header
            -- wrapped with '#' markers, max 80 chars wide.
            vim.keymap.set("n", "<leader>ch", function()
                local line = vim.api.nvim_get_current_line()
                local text = line:match("^%s*(.-)%s*$") -- trim whitespace

                -- Resolve comment string.
                local cs = vim.bo.commentstring
                if not cs or cs == "" then cs = "# %s" end

                -- Split commentstring into prefix/suffix around "%s".
                local cs_left, cs_right = cs:match("^(.-)%%s(.-)$")
                if not cs_left then -- malformed commentstring with no %s
                    cs_left, cs_right = "#", ""
                end
                cs_left = cs_left:gsub("%s+$", "") -- strip trailing space
                cs_right = cs_right:gsub("^%s+", "") -- strip leading space

                -- Use the last non-space character of the comment prefix as fill.
                local fill_char = cs_left:match("(.)%s*$") or "-"

                -- Build the header inside the comment markers.
                -- Total width = 80; subtract comment prefix/suffix lengths.
                -- Assembly: cs_left .. header [ .. " " .. cs_right ]
                -- No space between cs_left and header: fill chars flow directly from prefix.
                local total_width = 80

                local suffix_overhead = cs_right ~= "" and (#cs_right + 1) or 0
                local comment_overhead = #cs_left + suffix_overhead
                local inner_width = total_width - comment_overhead

                -- Pad text with one space on each side before centering.
                local text_padded = " " .. text .. " "
                local remaining = inner_width - #text_padded
                if remaining < 2 then
                    vim.notify("<leader>ch: text too long to fit in 80 chars", vim.log.levels.WARN)
                    remaining = 2
                end

                local left_fill = math.floor(remaining / 2)
                local right_fill = remaining - left_fill

                local header = string.rep(fill_char, left_fill) .. text_padded .. string.rep(fill_char, right_fill)

                -- Wrap in comment markers.
                local commented
                if cs_right ~= "" then
                    commented = cs_left .. header .. " " .. cs_right
                else
                    commented = cs_left .. header
                end

                vim.api.nvim_set_current_line(commented)
            end, { desc = "Comment header: center current line" })
            require("mini.jump").setup()
            require("mini.files").setup()
        end,
        init = function()
            local minifiles_toggle = function()
                local buf_name = vim.api.nvim_buf_get_name(0)
                local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
                local _ = MiniFiles.close() or MiniFiles.open(path)
            end

            vim.keymap.set("n", "<C-n>", minifiles_toggle, { silent = true })

            local map_split = function(buf_id, lhs, direction)
                local rhs = function()
                    -- Make new window and set it as target
                    local cur_target = MiniFiles.get_explorer_state().target_window
                    local new_target = vim.api.nvim_win_call(cur_target, function()
                        vim.cmd(direction .. " split")
                        return vim.api.nvim_get_current_win()
                    end)

                    MiniFiles.set_target_window(new_target)

                    -- This intentionally doesn't act on file under cursor in favor of
                    -- explicit "go in" action (`l` / `L`). To immediately open file,
                    -- add appropriate `MiniFiles.go_in()` call instead of this comment.
                end

                -- Adding `desc` will result into `show_help` entries
                local desc = "Split " .. direction
                vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Tweak keys to your liking
                    map_split(buf_id, "<C-s>", "belowright horizontal")
                    map_split(buf_id, "<C-v>", "belowright vertical")
                    map_split(buf_id, "<C-t>", "tab")
                end,
            })

            local show_dotfiles = true

            local filter_show = function(_fs_entry) return true end

            local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, ".") end

            local toggle_dotfiles = function()
                show_dotfiles = not show_dotfiles
                local new_filter = show_dotfiles and filter_show or filter_hide
                MiniFiles.refresh({ content = { filter = new_filter } })
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Tweak left-hand side of mapping to your liking
                    vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
                end,
            })

            local set_mark = function(id, path, desc) MiniFiles.set_bookmark(id, path, { desc = desc }) end
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesExplorerOpen",
                callback = function()
                    set_mark("w", vim.fn.getcwd, "Working directory") -- callable
                end,
            })
        end,
    },
}
