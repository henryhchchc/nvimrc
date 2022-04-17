local M = {}

function M.configure()
    if vim.fn.argc() > 0 then
        local arg0 = vim.fn.argv(0)
        local stat = vim.loop.fs_stat(arg0)
        if stat ~= nil and stat.type == "directory" then vim.cmd.cd(arg0) end
    end
end

return M
