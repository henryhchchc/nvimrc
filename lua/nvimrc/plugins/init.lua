--- @type LazyPluginSpec[]
return {
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Neogit",
    opts = {
      disable_line_numbers = false,
      graph_style = "unicode",
      commit_editor = { kind = "vsplit" },
      preview_buffer = { kind = "vsplit" },
      popup = { kind = "vsplit" },
    },
  },
  { "stevearc/oil.nvim", cmd = "Oil", config = true },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, event = { "BufReadPre", "BufNewFile" } },
  { "folke/which-key.nvim", config = true, event = "UIEnter" },
  { "kylechui/nvim-surround", config = true, event = "VeryLazy" },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function (_plugin, opts)
      require("rainbow-delimiters.setup").setup(opts)
    end,
    submodules = false,
  },
}
