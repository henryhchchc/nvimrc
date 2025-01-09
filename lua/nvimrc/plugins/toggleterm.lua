require("toggleterm").setup({
  size = function (term)
    if term.direction == "horizontal" then
      return 25
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
})


vim.keymap.set("n", "<leader><cr>", function () vim.cmd.ToggleTerm() end, { desc = "Toggle terminal" })
vim.keymap.set("n", "<leader><A-cr>", function () vim.cmd.ToggleTerm({ args = { "direction=float" } }) end,
  { desc = "Toggle terminal" })
