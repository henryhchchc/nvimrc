local M = {}

--- @type Flash.Config
local options = {
    search = {
        exclude = {
            "notify",
            "cmp_menu",
            "noice",
            "flash_prompt",
            "qf",
            "NvimTree",
            function(win)
                -- exclude non-focusable windows
                return not vim.api.nvim_win_get_config(win).focusable
            end,
        },
    },
}

--- @type LazyKeys[]
local keymaps = {
    {
        "S",
        mode = { "n", "o", "x" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
    },
    {
        "r",
        mode = "o",
        function() require("flash").remote() end,
        desc = "Remote Flash",
    },
    {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Flash Treesitter Search",
    },
    {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc = "Toggle Flash Search",
    },
}

--- @type LazyPluginSpec
M.pluginSpec = { "folke/flash.nvim", event = "VeryLazy", opts = options, keys = keymaps }

return M
