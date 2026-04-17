local setup = require("nvimrc.plugins.telescope.setup")
local keys = require("nvimrc.plugins.telescope.keys")

--- @type LazyPluginSpec
return {
  "nvim-telescope/telescope.nvim",
  config = function (_plugin, _opts)
    setup.setup()
  end,
  keys = keys,
}
