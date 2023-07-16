local lsp = require("nvimrc.dev.lsp")
local cmp = require("nvimrc.dev.cmp")
local dap = require("nvimrc.dev.dap")
local nullLs = require("nvimrc.dev.nullls")

local clangd = require("nvimrc.dev.lsp.clangd")
local texlab = require("nvimrc.dev.lsp.texlab")
local luadev = require("nvimrc.dev.lsp.luadev")

local M = {}

--- @type LazyPluginSpec[]
M.pluginSpecs = {
    { "neovim/nvim-lspconfig", config = lsp.configure, event = "VeryLazy" },
    cmp.pluginSpec,
    nullLs.pluginSpec,
    dap.pluginSpec,
    clangd.pluginSpec,
    texlab.backwardSearchPluginSpec,
    luadev.pluginSpec,
    { "folke/neoconf.nvim", cmd = "Neoconf", dependencies = { "nvim-lspconfig" } },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
            local rename_func = function() return ":IncRename " .. vim.fn.expand("<cword>") end
            vim.keymap.set("n", "<leader>rn", rename_func, { expr = true, desc = "LSP Rename" })
        end,
        event = "LspAttach",
    },
    { "simrat39/rust-tools.nvim", ft = { "rust" }, config = lsp.servers.setupRustAnalyzer },
    {
        "saecki/crates.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "jose-elias-alvarez/null-ls.nvim" },
        opts = { null_ls = { enabled = true, name = "crates.nvim" } },
        event = "BufRead Cargo.toml",
    },
    {
        "kosayoda/nvim-lightbulb",
        event = "LspAttach",
        opts = {
            sign = { enabled = false },
            autocmd = { enabled = true },
            virtual_text = { enabled = true, text = "󰌶", hl_mode = "combine" },
        },
    },
    {
        "zbirenbaum/copilot.lua",
        config = true,
        cmd = "Copilot",
        event = "InsertEnter",
    },
}

return M
