vim.loader.enable()

if vim.fn.argc() > 0 then
  local arg0 = vim.fn.argv(0)
  local stat = type(arg0) == "string" and vim.loop.fs_stat(arg0) or nil
  if stat ~= nil and stat.type == "directory" then vim.cmd.cd(arg0) end
end

require("nvimrc.config.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Setting up Lazy.nvim <https://github.com/folke/lazy.nvim>")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "nvimrc.lazy_plugins" },
    { import = "nvimrc.lazy_plugins.ui" },
  },
  defaults = {
    lazy = true,
    version = "*",
  },
  ui = {
    border = "rounded",
    title = " Lazy.nvim - Plugin Manager ",
  },
})

require("nvimrc.config.keymap")
require("nvimrc.config.autocmds")
require("nvimrc.config.diagnostic")
