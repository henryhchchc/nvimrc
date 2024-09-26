--- @type LazyPluginSpec
return {
  "OXY2DEV/markview.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "Markview" },
  config = true,
}
