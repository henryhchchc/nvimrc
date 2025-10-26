--- @type LazyPluginSpec[]
return {
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Neogit",
    opts = {
      disable_builtin_notifications = true,
      disable_commit_confirmation = true,
      disable_line_numbers = false,
      graph_style = "unicode",
      commit_popup = { kind = "vsplit" },
      preview_buffer = { kind = "vsplit" },
      popup = { kind = "vsplit" },
    },
  },
  { "stevearc/oil.nvim", cmd = "Oil", config = true },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
  },
  { "nvimtools/none-ls.nvim", event = "VimEnter" },
  { "MunifTanjim/nui.nvim" },
  { "b0o/schemastore.nvim" },
  { "folke/which-key.nvim", config = true, event = "UIEnter" },
  { "kylechui/nvim-surround", config = true, event = "VeryLazy" },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufEnter",
    config = function (self, opts)
      require("rainbow-delimiters.setup").setup(opts)
    end,
    submodules = false,
  },
}
