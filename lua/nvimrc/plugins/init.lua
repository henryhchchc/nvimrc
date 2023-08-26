--- @type LazyPluginSpec[]
return {
  {
    "stevearc/dressing.nvim",
    opts = { input = { enabled = false } },
    event = "VeryLazy",
  },
  {
    "jiaoshijie/undotree",
    event = "VeryLazy",
    config = true,
    keys = {
      {
        "<leader>gu",
        function() require("undotree").toggle() end,
        desc = "Toggle Undo Tree",
      },
    },
  },
  { "nvim-tree/nvim-web-devicons" },
  { "folke/which-key.nvim", config = true, event = "VeryLazy" },
  {
    "stevearc/aerial.nvim",
    opts = {
      backends = { "lsp", "treesitter", "markdown", "man" },
      min_width = 20,
    },
    cmd = { "AerialToggle", "AerialOpen", "AerialOpenAll" },
  },
  {
    "folke/todo-comments.nvim",
    config = true,
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>xt", function() vim.cmd.TodoTrouble() end, desc = "Todo list (Trouble)" },
    },
  },
  {
    "RRethy/vim-illuminate",
    config = function() require("illuminate").configure({ providers = { "lsp", "treesitter" } }) end,
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = { easing_function = "cubic" },
  },
  { "kevinhwang91/nvim-bqf", ft = "qf", opts = { auto_resize_height = true } },
}
