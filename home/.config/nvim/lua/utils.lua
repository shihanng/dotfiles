local M = {}

M.append_o = function(opt, str, sep)
    sep = sep or ""
    if vim.o[opt] and #vim.o[opt] ~= 0 then
        vim.o[opt] = (vim.o[opt] .. sep .. str)
    else
        vim.o[opt] = str
    end
end

return M
