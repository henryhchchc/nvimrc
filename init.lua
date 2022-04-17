require("config.global")
require("config.gui")
if not vim.g.vscode then
    require("config.packer")
end
