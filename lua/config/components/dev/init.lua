local lsp = require("config.components.dev.lsp")
local cmp = require("config.components.dev.cmp")
local nullLs = require("config.components.dev.null-ls")
local lspSaga = require("config.components.dev.lspsaga")

local M = {}

function M.packer(use)
    use({
        "neovim/nvim-lspconfig",
        requires = {
            { "p00f/clangd_extensions.nvim" },
        },
    })
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

    use({ "tami5/lspsaga.nvim" })
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            -- { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
            { "saadparwaiz1/cmp_luasnip" },
            { "L3MON4D3/LuaSnip" },
            { "onsails/lspkind-nvim" },
        },
    })
    use({ "simrat39/rust-tools.nvim" })
    use({ "jose-elias-alvarez/null-ls.nvim" })
end

function M.configure()
    lsp.configure()
    nullLs.configure()
    lspSaga.configure()
    cmp.configure()
end

return M
