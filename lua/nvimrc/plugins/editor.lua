--- @type LazyPluginSpec[]
return {
  {
    "windwp/nvim-autopairs",
    dependencies = { { "nvim-treesitter/nvim-treesitter" } },
    opts = { check_ts = true },
    event = "InsertEnter",
  },
  { "RRethy/nvim-align", cmd = "Align" },
  { "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
  { "kylechui/nvim-surround", config = true, event = { "BufReadPost", "BufNewFile" } },
}
