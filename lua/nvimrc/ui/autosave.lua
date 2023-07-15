local M = {}

local autoSaveOptions = {
    enabled = true,
    execution_message = {
        message = function() return string.format("[AutoSave] Written: %s", vim.fn.expand("%:t") or "[Unnamed]") end,
    },
}

--- @type LazyPluginSpec
M.pluginSpec = { "Pocco81/auto-save.nvim", opts = autoSaveOptions, event = "VeryLazy" }

return M
