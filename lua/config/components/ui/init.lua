local colors = require("config.components.ui.colors")
local lualine = require("config.components.ui.lualine")
local bufferline = require("config.components.ui.bufferline")
local nvimTree = require("config.components.ui.nvimtree")
local telescope = require("config.components.ui.telescope")
local toggleTerm = require("config.components.ui.toggle-term")
local navigator = require("config.components.ui.navigator")
local notify = require("config.components.ui.notify")

local M = {}

local function configureColorScheme()
    local nightFox = require("nightfox")
    nightFox.setup({
        palettes = {
            nordfox = colors.nordFox
        }
    })
    vim.cmd("colorscheme nordfox")
end

function M.packer(use)
    use({ "kyazdani42/nvim-web-devicons" })
    use({ "EdenEast/nightfox.nvim" })
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
    use({ "folke/which-key.nvim" })
    use({ "simrat39/symbols-outline.nvim" })
    use({ "rcarriga/nvim-notify" })
end

function M.configure()
    configureColorScheme()
    notify.configure()
    nvimTree.configure()
    bufferline.configure()
    lualine.configure()
    toggleTerm.configure()
    navigator.configure()
    telescope.configure()
    require("which-key").setup()
end

return M
