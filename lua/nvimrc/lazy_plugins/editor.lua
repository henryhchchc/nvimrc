--- @type LazyPluginSpec[]
return {
  {
    "windwp/nvim-autopairs",
    dependencies = { { "nvim-treesitter/nvim-treesitter" } },
    opts = { check_ts = true },
    event = "InsertEnter",
  },
  { "kylechui/nvim-surround", config = true, event = { "BufReadPost", "BufNewFile" } },
}
