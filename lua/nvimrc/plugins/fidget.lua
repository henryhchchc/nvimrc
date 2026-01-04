--- @type LazyPluginSpec
return {
  "j-hui/fidget.nvim",
  opts = {},
  config = function (_plugin, opts)
    require("fidget").setup(opts)
    vim.notify = require("fidget.notification").notify
  end,
  event = "VeryLazy",
}
