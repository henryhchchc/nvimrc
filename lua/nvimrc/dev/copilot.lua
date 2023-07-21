local M = {}

--- @type LazyPluginSpec
M.pluginSpec = {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
  },
  cmd = "Copilot",
}

return M
