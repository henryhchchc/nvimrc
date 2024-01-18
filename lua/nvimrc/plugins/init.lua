--- @type LazyPluginSpec[]
return {
  {
    "jiaoshijie/undotree",
    event = "VeryLazy",
    config = true,
    keys = {
      {
        "<leader>gu",
        function () require("undotree").toggle() end,
        desc = "Toggle Undo Tree",
      },
    },
  },
  { "nvim-tree/nvim-web-devicons" },
  { "folke/which-key.nvim", config = true, event = "VeryLazy" },
  {
    "folke/todo-comments.nvim",
    config = true,
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>xt", function () vim.cmd.TodoTrouble() end, desc = "Todo list (Trouble)" },
    },
  },
  { "kevinhwang91/nvim-bqf", ft = "qf", opts = { auto_resize_height = true } },
}
