local lsp = require("config.components.dev.lsp")
local cmp = require("config.components.dev.cmp")
local dap = require("config.components.dev.dap")
local nullLs = require("config.components.dev.nullls")

local jdtls = require("config.components.dev.lsp.jdtls")
local clangd = require("config.components.dev.lsp.clangd")
local texlab = require("config.components.dev.lsp.texlab")
local luadev = require("config.components.dev.lsp.luadev")

local M = {}

M.pluginSpecs = {
    { "neovim/nvim-lspconfig", config = lsp.configure, event = "VeryLazy" },
    cmp.pluginSpec,
    nullLs.pluginSpec,
    dap.pluginSpec,
    jdtls.pluginSpec,
    clangd.pluginSpec,
    texlab.backwardSearchPluginSpec,
    luadev.pluginSpec,
    { "folke/neoconf.nvim", config = false, cmd = "Neoconf", dependencies = { "nvim-lspconfig" } },
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
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        cmd = { "TroubleToggle", "Trouble" },
        config = true,
    },
}

return M
