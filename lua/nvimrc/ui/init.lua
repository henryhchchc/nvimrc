local M = {}

--- @type LazyPluginSpec[]
M.pluginSpecs = {
  require("nvimrc.ui.noice").pluginSpec,
  require("nvimrc.ui.neotree").pluginSpec,
  require("nvimrc.ui.lualine").pluginSpec,
  require("nvimrc.ui.catppuccin").pluginSpec,
  require("nvimrc.ui.telescope").pluginSpec,
  require("nvimrc.ui.flash").pluginSpec,
  require("nvimrc.ui.indent").pluginSpec,
  require("nvimrc.ui.colorizer").pluginSpec,
  require("nvimrc.ui.notify").pluginSpec,
  require("nvimrc.ui.trouble").pluginSpec,
  require("nvimrc.ui.bufferline").pluginSpec,
  require("nvimrc.ui.headlines").pluginSpec,
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
  {
    "stevearc/dressing.nvim",
    opts = { input = { enabled = false } },
    event = "VeryLazy",
  },
  {
    "windwp/nvim-autopairs",
    dependencies = { { "nvim-treesitter/nvim-treesitter" } },
    opts = { check_ts = true },
    event = "InsertEnter",
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
  { "RRethy/nvim-align", cmd = "Align" },
  { "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
  { "kylechui/nvim-surround", config = true, event = { "BufReadPost", "BufNewFile" } },
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
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>hh",
        function() require("harpoon.ui").toggle_quick_menu() end,
        desc = "Harpoon",
      },
      {
        "<leader>ha",
        function() require("harpoon.mark").add_file() end,
        desc = "Add Current File to Harpoon",
      },
    },
  },
}

return M
