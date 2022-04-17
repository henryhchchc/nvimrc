local lualine = require("config.components.ui.lualine")
local tabby = require("config.components.ui.tabby")
local nvimTree = require("config.components.ui.nvimtree")
local telescope = require("config.components.ui.telescope")
local nordfox = require("config.components.ui.nordfox")
local noice = require("config.components.ui.noice")
local flash = require("config.components.ui.flash")
local indent = require("config.components.ui.indent")
local colorizer = require("config.components.ui.colorizer")
local autosave = require("config.components.ui.autosave")
local notify = require("config.components.ui.notify")

local M = {}

M.pluginSpecs = {
    noice.pluginSpec,
    tabby.pluginSpec,
    nvimTree.pluginSpec,
    lualine.pluginSpec,
    nordfox.pluginSpec,
    telescope.pluginSpec,
    flash.pluginSpec,
    indent.pluginSpec,
    colorizer.pluginSpec,
    autosave.pluginSpec,
    notify.pluginSpec,
    { "mvllow/modes.nvim", config = true, event = "VeryLazy" },
    {
        "stevearc/dressing.nvim",
        opts = { input = { enabled = false } },
        event = "VeryLazy",
    },
    {
        "windwp/nvim-autopairs",
        dependencies = { { "nvim-treesitter/nvim-treesitter" } },
        opts = { check_ts = true },
        event = "InsertEnter",
    },
    {
        "jiaoshijie/undotree",
        event = "VeryLazy",
        config = true,
        keys = {
            {
                "<leader>gu",
                function() require("undotree").toggle() end,
                desc = "Toggle Undo Tree",
            },
        },
    },
    { "RRethy/nvim-align", cmd = "Align" },
    { "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
    {
        "echasnovski/mini.surround",
        opts = {
            mappings = {
                add = "<leader>sa",
                delete = "<leader>sd",
                find = "<leader>sf",
                find_left = "<leader>sF",
                highlight = "<leader>sh",
                replace = "<leader>sr",
                update_n_lines = "<leader>sn",
            },
        },
        event = "VeryLazy",
    },
    { "nvim-tree/nvim-web-devicons" },
    { "famiu/bufdelete.nvim", cmd = { "Bdelete" } },
    { "folke/which-key.nvim", config = true, event = "VeryLazy" },
    {
        "stevearc/aerial.nvim",
        opts = {
            backends = { "lsp", "treesitter", "markdown", "man" },
            min_width = 20,
        },
        cmd = { "AerialToggle", "AerialOpen", "AerialOpenAll" },
    },
    {
        "folke/todo-comments.nvim",
        config = true,
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "RRethy/vim-illuminate",
        config = function() require("illuminate").configure({ providers = { "lsp", "treesitter" } }) end,
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        opts = { easing_function = "cubic" },
    },
    { "kevinhwang91/nvim-bqf", ft = "qf", opts = { auto_resize_height = true } },
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>hh",
                function() require("harpoon.ui").toggle_quick_menu() end,
                desc = "Harpoon",
            },
            {
                "<leader>ha",
                function() require("harpoon.mark").add_file() end,
                desc = "Add Current File to Harpoon",
            },
        },
    },
}

return M
