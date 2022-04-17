local function configure()
    local neogit = require("neogit")
    neogit.setup({
        kind = "vsplit",
    })
    vim.keymap.set("n", "<leader>ng", neogit.open, { desc = "Open Neogit" })
end

return configure
