local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
require("nvimrc.bootstrap.lazy").ensure_installed(lazy_path)

vim.opt.rtp:prepend(lazy_path)

--- @type LazyConfig
local lazy_options = {
  defaults = {
    versions = "*",
  },
  spec = {
    { import = "nvimrc.plugins" },
  },
  rocks = {
    enabled = false,
  },
}

require("lazy").setup(lazy_options)
