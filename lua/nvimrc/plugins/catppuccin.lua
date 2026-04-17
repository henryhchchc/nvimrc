--- @type LazyPluginSpec
return {
  "catppuccin/nvim",
  main = "catppuccin",
  name = "catppuccin",
  priority = 1000,
  opts = require("nvimrc.plugins.catppuccin.opts"),
  config = function (_plugin, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
