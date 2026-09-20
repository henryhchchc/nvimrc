local treesitter_config = require("nvimrc.plugins.treesitter.config")

--- @type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = treesitter_config.setup,
  },
}
