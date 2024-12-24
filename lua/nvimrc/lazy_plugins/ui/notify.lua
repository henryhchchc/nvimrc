--- @type LazyPluginSpec
return {
  "rcarriga/nvim-notify",
  keys = {
    {
      "<leader>un",
      function () package.loaded.notify.dismiss({ silent = true, pending = true }) end,
      desc = "Dismiss all Notifications",
    },
  },
  --- @type notify.Config
  opts = {
    timeout = 3000,
    max_height = function () return math.floor(vim.o.lines * 0.75) end,
    max_width = function () return math.floor(vim.o.columns * 0.75) end,
  },
}
