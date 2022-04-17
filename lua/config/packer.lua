vim.cmd("packadd packer.nvim")
local packer = require("packer")

local function packerStartup(use)
    use({ "wbthomason/packer.nvim" })
    use({ "nvim-lua/plenary.nvim" })
    use({ "marko-cerovac/material.nvim", config = require("config.plugins.material") })

    use({
        "nvim-treesitter/nvim-treesitter",
        requires = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
        },
        run = ":TSUpdate",
        config = require("config.plugins.treesitter"),
    })

    use({ "kyazdani42/nvim-web-devicons" })

    use({ "neovim/nvim-lspconfig", config = require("config.plugins.lsp") })
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

    use({
        "stevearc/aerial.nvim",
        requires = {
            { "onsails/lspkind-nvim" },
        },
        config = require("config.plugins.aerial"),
    })
    use({ "tami5/lspsaga.nvim", config = require("config.plugins.lspsaga") })
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
        config = require("config.plugins.cmp"),
    })

    use({ "jose-elias-alvarez/null-ls.nvim", config = require("config.plugins.null-ls") })

    use({ "lukas-reineke/indent-blankline.nvim", config = require("config.plugins.blankline") })
    -- stylua: ignore
    use({ "numToStr/Comment.nvim", config = function() require("Comment").setup() end, })

    use({ "akinsho/bufferline.nvim", config = require("config.plugins.bufferline") })
    use({ "famiu/bufdelete.nvim" })
    use({
        "nvim-lualine/lualine.nvim",
        requires = {
            { "SmiteshP/nvim-gps" },
            { "arkav/lualine-lsp-progress" },
        },
        after = { "material.nvim" },
        config = require("config.plugins.lualine"),
    })
    use({
        "kyazdani42/nvim-tree.lua",
        config = require("config.plugins.nvimtree"),
    })

    use({ "phaazon/hop.nvim", config = require("config.plugins.hop") })
    use({
        "windwp/nvim-autopairs",
        requires = {
            { "nvim-treesitter/nvim-treesitter" },
        },
        after = { "nvim-treesitter" },
        config = require("config.plugins.autopair"),
    })
    use({ "RRethy/nvim-align" })

    use({
        "TimUntersberger/neogit",
        requires = "nvim-lua/plenary.nvim",
        config = require("config.plugins.neogit"),
    })

    use({
        "lewis6991/gitsigns.nvim",
        config = require("config.plugins.gitsigns"),
    })

    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "jvgrootveld/telescope-zoxide" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        config = require("config.plugins.telescope"),
    })

    use({ "numToStr/Navigator.nvim", config = require("config.plugins.navigator") })
    use({ "akinsho/toggleterm.nvim", config = require("config.plugins.toggle-term") })

    -- stylua: ignore
    use({ "xiyaowong/which-key.nvim", config = function() require("which-key").setup() end, })
    -- stylua: ignore
    use({ "Pocco81/AutoSave.nvim", config = function() require("autosave").setup({ enabled = false }) end, })
    -- stylua: ignore
    use({ "simrat39/rust-tools.nvim", config = function() require("rust-tools").setup({}) end, })
    use({ "p00f/clangd_extensions.nvim" })

    -- stylua: ignore
    use({ "norcalli/nvim-colorizer.lua", config = function() require("colorizer").setup() end, })
end

packer.startup({
    packerStartup,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end,
        },
    },
})
