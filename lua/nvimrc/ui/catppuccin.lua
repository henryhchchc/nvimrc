local M = {}

local terminal = {
    background = "#151515",
    alt_background = "#1F1F1F",
}

--- @type CatppuccinOptions
local catppuccinOptions = {
    transparent_background = true,
    highlight_overrides = {
        mocha = function(colors)
            return {
                NormalFloat = { bg = colors.base },
                NotifyBackground = { bg = "#000000" },
            }
        end,
    },
    color_overrides = {
        mocha = {
            base = terminal.alt_background,
        },
    },
    integrations = {
        bufferline = true,
        noice = true,
        notify = true,
        neotree = true,
        nvimtree = false,
        illuminate = true,
        harpoon = true,
        lsp_trouble = true,
        which_key = true,
        neogit = true,
        navic = {
            enabled = true,
            custom_bg = "NONE",
        },
    },
}

M.pluginSpec = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
        require("catppuccin").setup(catppuccinOptions)
        vim.cmd.colorscheme("catppuccin-mocha")
    end,
}

return M
