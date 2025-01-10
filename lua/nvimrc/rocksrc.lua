local M = {}

local rocks_config = {
  rocks_path = vim.fn.stdpath("data") .. "/rocks",
}

function M.install_rocks_nvim()
  vim.notify("Installing rocks.nvim...")
  local status = vim.system({
    "luarocks",
    "--lua-version=5.1",
    "--tree=" .. rocks_config.rocks_path,
    "--server='https://nvim-neorocks.github.io/rocks-binaries/'",
    "install",
    "rocks.nvim",
  }):wait()
  if status.code == 0 then
    vim.notify("rocks.nvim installed successfully.")
  else
    vim.notify("Failed to install rocks.nvim.")
  end
end

function M.initialize()
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
end

return M
