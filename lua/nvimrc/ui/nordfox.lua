local M = {}

local nordColors = require("nvimrc.ui.nord").colors
local terminal = {
    background = "#151515",
}

local nordFoxOptions = {
    options = {
        styles = {
            keywords = "bold",
            comments = "italic",
        },
    },
    palettes = {
        nordfox = {
            bg0 = "#1F1F1F",
            bg1 = terminal.background,
            bg3 = nordColors.nord0,
            sel0 = "#424242",
        },
    },
    groups = {
        nordfox = {
            VertSplit = { fg = nordColors.nord3 },
            FloatBorder = { bg = "#1F1F1F" },
            NoiceSplit = { bg = terminal.background },
            LspInfoBorder = { link = "FloatBorder" },
            BqfPreviewBorder = { link = "TelescopeBorder" },
            SpellBad = { style = "underline" },
            SpellCap = { style = "underline" },
            SpellLocal = { style = "underline" },
            SpellRare = { style = "underline" },
            EndOfBuffer = { fg = nordColors.nord3 },
        },
    },
}

local function configureNightfox()
    local nightFox = require("nightfox")
    nightFox.setup(nordFoxOptions)
    vim.cmd.colorscheme("nordfox")
end

M.pluginSpec = { "EdenEast/nightfox.nvim", priority = 1000, lazy = false, config = configureNightfox }

return M
