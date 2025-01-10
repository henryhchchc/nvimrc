vim.loader.enable()

if vim.fn.argc() > 0 then
  local arg0 = vim.fn.argv(0)
  local stat = type(arg0) == "string" and vim.loop.fs_stat(arg0) or nil
  if stat ~= nil and stat.type == "directory" then vim.cmd.cd(arg0) end
end

require("nvimrc.config.options")

local rocks_config = {
  rocks_path = vim.fn.stdpath("data") .. "/rocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
  vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
  vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),

  -- add these on Windows
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))

require("nvimrc.config.theme")

require("nvimrc.config.autocmds")
require("nvimrc.config.diagnostic")
require("nvimrc.config.keymap")
