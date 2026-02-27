vim.loader.enable()

if vim.fn.argc() > 0 then
  local arg0 = vim.fn.argv(0)
  local stat = type(arg0) == "string" and vim.uv.fs_stat(arg0)
  if stat and stat.type == "directory" then vim.cmd.cd(arg0) end
end

require("nvimrc.config.options")
require("nvimrc.lazy")

require("nvimrc.config.autocmds")
require("nvimrc.config.diagnostic")
require("nvimrc.config.keymap")
require("nvimrc.config.ft")
