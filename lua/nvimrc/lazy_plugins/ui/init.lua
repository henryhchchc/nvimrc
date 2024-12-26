--- @type LazyPluginSpec[]
return {
  {
    "stevearc/dressing.nvim",
    opts = { input = { enabled = false } },
    event = "VeryLazy",
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
    config = function (_self, opts)
      require("fidget").setup(opts)
      vim.notify = require("fidget.notification").notify
    end,
    event = "VeryLazy",
  },
}
