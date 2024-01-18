--- @type LazyPluginSpec[]
return {
  {
    "windwp/nvim-autopairs",
    dependencies = { { "nvim-treesitter/nvim-treesitter" } },
    opts = { check_ts = true },
    event = "InsertEnter",
  },
  { "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
  { "kylechui/nvim-surround", config = true, event = { "BufReadPost", "BufNewFile" } },
  {
    "RRethy/vim-illuminate",
    opts = {
      providers = { "lsp", "treesitter" },
    },
    config = function (self, opts)
      require("illuminate").configure(opts)
    end,
    event = { "BufReadPost", "BufNewFile" },
  },
}
