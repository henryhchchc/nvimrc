local M = {}
function M.configure()
    local navigator = require("Navigator")
    navigator.setup()

    vim.keymap.set("n", "<C-h>", navigator.left, { desc = "Navigator Go Left" })
    vim.keymap.set("n", "<C-j>", navigator.down, { desc = "Navigator Go Down" })
    vim.keymap.set("n", "<C-k>", navigator.up, { desc = "Navigator Go Up" })
    vim.keymap.set("n", "<C-l>", navigator.right, { desc = "Navigator Go Right" })
    vim.keymap.set("n", "<C-w><C-p>", navigator.previous, { desc = "Navigator Go Back" })
end

return M
