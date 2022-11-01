local M = {}

function M.trim_trailing_whitespaces()
    if not vim.o.binary and vim.o.filetype ~= "diff" then
        local saved_view = vim.fn.winsaveview()
        vim.cmd([[ silent! keepjumps keeppatterns %s/\s\+$//e ]]) -- trim trailing whitespaces
        -- vim.cmd([[ silent! keepjumps keeppatterns %s/\n*\%$//e ]]) -- trim trailing newlines
        vim.fn.winrestview(saved_view)
    end
end

return M
