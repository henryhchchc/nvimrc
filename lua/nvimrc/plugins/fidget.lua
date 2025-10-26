--- @type LazyPluginSpec
return {
  "j-hui/fidget.nvim",
  opts = {
    notification = {
      window = {
        winblend = 0,
      },
    },
  },
  config = function(self, opts)
    require("fidget").setup(opts)
    vim.notify = require("fidget.notification").notify
  end,
  event = "VeryLazy",
}
