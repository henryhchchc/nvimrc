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
    version = "3.9.0",
    event = "BufEnter",
  },
  { "nvimtools/none-ls.nvim", version = "scm", event = "VimEnter" },
  { "MunifTanjim/nui.nvim", version = "0.4.0" },
  { "b0o/schemastore.nvim", version = "0.2.0" },
  { "folke/which-key.nvim", version = "3.17.0", config = true, event = "UIEnter" },
  { "kylechui/nvim-surround", version = "3.1.6", config = true, event = "VeryLazy" },
  {
    "HiPhish/rainbow-delimiters.nvim",
    version = "0.9.1",
    event = "BufEnter",
    config = function (self, opts)
      require("rainbow-delimiters.setup").setup(opts)
    end,
    submodules = false,
  },
}
