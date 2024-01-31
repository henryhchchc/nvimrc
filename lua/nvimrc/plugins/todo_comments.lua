--- @type LazyPluginSpec
return {
  "folke/todo-comments.nvim",
  --- @type TodoOptions
  opts = {
    highlight = {
      keyword = "",
      after = "",
    },
    colors = {
      error = { "@comment.error" },
      warning = { "@comment.warning" },
      info = { "@comment.note" },
      hint = { "@comment.note" },
      default = { "@comment.todo" },
      test = { "@comment.todo" },
    },
  },
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<leader>xt", function () vim.cmd.TodoTrouble() end, desc = "Todo list (Trouble)" },
  },
}
