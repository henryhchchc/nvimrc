require("config.global")
require("config.gui")
require("config.packer")

if not vim.g.vscode then
    local dev = require("config.components.dev")
    dev.configure()

    local ui = require("config.components.ui")
    ui.configure()
end
