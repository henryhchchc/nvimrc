local colors = require("config.components.ui.colors")
local lualine = require("config.components.ui.lualine")
local bufferline = require("config.components.ui.bufferline")
local nvimTree = require("config.components.ui.nvimtree")
local telescope = require("config.components.ui.telescope")
local toggleTerm = require("config.components.ui.toggle-term")
local navigator = require("config.components.ui.navigator")

local M = {}

local function configureColorScheme()
    vim.g.material_style = "darker"
    require("material").setup({
        contrast = {
            popup_menu = true,
        },
        high_visibility = {
            darker = true,
        },
        custom_colors = colors.colorPalette,
        async_loading = true,
    })
    vim.cmd("colorscheme material")
end

function M.packer(use)
    use({ "kyazdani42/nvim-web-devicons" })
    use({ "marko-cerovac/material.nvim" })
    use({
        "nvim-lualine/lualine.nvim",
        requires = {
            { "SmiteshP/nvim-gps" },
            { "arkav/lualine-lsp-progress" },
        },
    })
    use({ "akinsho/bufferline.nvim" })
    use({ "famiu/bufdelete.nvim" })
    use({ "kyazdani42/nvim-tree.lua" })
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "jvgrootveld/telescope-zoxide" },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "nvim-telescope/telescope-dap.nvim" },
            { "nvim-telescope/telescope-dap.nvim" },
        },
    })
    use({ "akinsho/toggleterm.nvim" })
    use({ "numToStr/Navigator.nvim" })
    use({ "xiyaowong/which-key.nvim" })
    use({ "simrat39/symbols-outline.nvim" })
end

function M.configure()
    configureColorScheme()
    nvimTree.configure()
    bufferline.configure()
    lualine.configure()
    toggleTerm.configure()
    navigator.configure()
    telescope.configure()
    require("which-key").setup()
end

return M
