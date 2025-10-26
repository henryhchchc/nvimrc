--- @type LazyPluginSpec
return {
  "akinsho/toggleterm.nvim",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 25
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
  },
  keys = {
    { "<leader><cr>", "<Cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    { "<leader><A-cr>", "<Cmd>ToggleTerm direction=float<cr>", desc = "Toggle terminal" },
  },
}
