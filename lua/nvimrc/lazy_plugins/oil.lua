vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
---@type LazyPluginSpec
return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Oil",
  -- keys = {
  --   { "n", "-", function () vim.cmd.Oil() end, { noremap = true, silent = true } },
  -- },
}
