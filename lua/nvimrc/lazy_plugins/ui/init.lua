--- @type LazyPluginSpec[]
return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        border = "none",
      },
    },
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
