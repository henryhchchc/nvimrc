require("config.global")
require("config.gui")
require("config.packer")

local ts = require("config.components.treesitter")
ts.configure()

if not vim.g.vscode then
    local dev = require("config.components.dev")
    dev.configure()

    local ui = require("config.components.ui")
    ui.configure()
end
