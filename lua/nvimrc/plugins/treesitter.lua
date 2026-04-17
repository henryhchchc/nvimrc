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
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufEnter",
    config = true,
    --- @type TSContext.UserConfig
    opts = {
      enable = true,
      max_lines = 6,
      min_window_height = 20,
    },
  },
}
