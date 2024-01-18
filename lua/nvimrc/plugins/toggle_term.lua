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
    size = function (term)
      if term.direction == "horizontal" then
        return 25
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
  },
  keys = {
    { "<leader><cr>", function () vim.cmd.ToggleTerm() end, desc = "Toggle terminal" },
    {
      "<leader><A-cr>",
      function () vim.cmd.ToggleTerm({ args = { "direction=float" } }) end,
      desc = "Toggle terminal",
    },
  },
}
