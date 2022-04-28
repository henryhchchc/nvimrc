local M = {}

function M.configure()
    local notify = require("notify")
    notify.setup({
        max_width = 70
    })
    vim.notify = notify
end

return M
