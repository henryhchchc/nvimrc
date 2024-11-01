--- @type LazyPluginSpec
return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "Trouble" },
  keys = {
    {
      "<leader>xx",
      function () vim.cmd.Trouble("diagnostics") end,
      desc = "Diagnostics (Trouble)",
    },
    { "<leader>xl", function () vim.cmd.Trouble("loclist") end, desc = "Location List (Trouble)" },
    { "<leader>xq", function () vim.cmd.Trouble("quickfix") end, desc = "Quickfix List (Trouble)" },
  },
  config = true,
  --- @type trouble.Config
  opts = {
    auto_jump = true,
    auto_close = true,
    focus = true,
    follow = false,
    pinned = true,
  },
}
