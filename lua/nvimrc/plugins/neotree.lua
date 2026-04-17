local opts = require("nvimrc.plugins.neotree.opts")

--- @type LazyPluginSpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "MunifTanjim/nui.nvim", lazy = true },
  },
  cmd = "Neotree",
  keys = {
    {
      "<leader>e",
      function ()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
  },
  opts = opts,
}
