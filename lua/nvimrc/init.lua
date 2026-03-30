vim.loader.enable()

if vim.fn.argc() > 0 then
  if vim.fn.len(vim.v.argf) > 0 then
    local file_arg = vim.v.argf[1]
    local stat = type(file_arg) == "string" and vim.uv.fs_stat(file_arg)
    if stat and stat.type == "directory" then vim.cmd.cd(file_arg) end
  end
end

require("vim._core.ui2").enable({ enable = true })

require("nvimrc.config.options")
require("nvimrc.lazy")

require("nvimrc.config.autocmds")
require("nvimrc.config.diagnostic")
require("nvimrc.config.keymap")
require("nvimrc.config.ft")
