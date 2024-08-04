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
}
