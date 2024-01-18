--- @type LazyPluginSpec
return {
  "nvimdev/flybuf.nvim",
  cmd = "FlyBuf",
  config = true,
  keys = {
    { "<leader>fb", function () vim.cmd.FlyBuf() end, desc = "Switch buffer" },
  },
}
