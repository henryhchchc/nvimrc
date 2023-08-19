local M = {}

local function configure_norg()
  local options = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
    },
  }

  require("neorg").setup(options)
end

--- @type LazyPluginSpec
M.pluginSpec = {
  "nvim-neorg/neorg",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = configure_norg,
  ft = { "norg" },
}

return M
