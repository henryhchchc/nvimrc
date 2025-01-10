vim.loader.enable()

if vim.fn.argc() > 0 then
  local arg0 = vim.fn.argv(0)
  local stat = type(arg0) == "string" and vim.uv.fs_stat(arg0) or nil
  if stat ~= nil and stat.type == "directory" then vim.cmd.cd(arg0) end
end

local rocksrc = require("nvimrc.rocksrc")

if vim.fn.executable("luarocks") ~= 1 then
  vim.notify("Luarocks not found. Please install luarocks and restart nvim.")
  return
end

rocksrc.initialize()

if not pcall(require, "rocks") then
  rocksrc.install_rocks_nvim()
end


require("nvimrc.config.options")
require("nvimrc.config.theme")
require("nvimrc.config.autocmds")
require("nvimrc.config.diagnostic")
require("nvimrc.config.keymap")
