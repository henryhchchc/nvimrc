--- @type LazyPluginSpec
return {
  "akinsho/toggleterm.nvim",
  cmd = {
    "ToggleTerm",
    "ToggleTermToggleAll",
    "TermExec",
    "TermSelect",
  },
  opts = {

  },
  keys = {
    { "<leader>ut", function() vim.cmd.ToggleTerm() end, desc = "Toggle terminal" }
  }
}
