local M = {}

--- @type LazyPluginSpec[]
M.pluginSpecs = {
  require("nvimrc.utility.gitsigns").pluginSpec,
  require("nvimrc.utility.neoorg").pluginSpec,
  require("nvimrc.utility.headlines").pluginSpec,
  { "tpope/vim-fugitive", cmd = "Git" },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    opts = {
      disable_builtin_notifications = true,
      disable_commit_confirmation = true,
      commit_popup = { kind = "vsplit" },
      preview_buffer = { kind = "vsplit" },
      popup = { kind = "vsplit" },
    },
    keys = {
      { "<leader>ghn", vim.cmd.Neogit, desc = "Neogit" },
    },
  },
}

return M
