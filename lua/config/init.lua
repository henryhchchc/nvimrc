vim.loader.enable()

require("config.global")

require("config.components.cddir").configure()

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

local ts = require("config.components.treesitter")
local dev = require("config.components.dev")
local ui = require("config.components.ui")
local vcs = require("config.components.vcs")

local plugins = {}

for _, component in ipairs({ ts, dev, ui, vcs }) do
    for _, p in ipairs(component.pluginSpecs) do
        table.insert(plugins, p)
    end
end

require("lazy").setup(plugins, {
    defaults = {
        lazy = true,
    },
})

require("config.components.keymap").configure()
require("config.components.autocmds").configure()
