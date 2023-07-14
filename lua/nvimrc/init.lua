vim.loader.enable()

require("nvimrc.global")

require("nvimrc.cddir").configure()

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

local ts = require("nvimrc.treesitter")
local dev = require("nvimrc.dev")
local ui = require("nvimrc.ui")
local vcs = require("nvimrc.vcs")

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

require("nvimrc.keymap").configure()
require("nvimrc.autocmds").configure()
