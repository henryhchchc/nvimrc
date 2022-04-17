--- @type LazyPluginSpec
return {
  "apple/pkl-neovim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  ft = "pkl",
  build = function ()
    vim.cmd.TSInstall("pkl")
  end,
}
