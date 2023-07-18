local M = {}

local function configure()
    --- @type bufferline.UserConfig
    local bufferlineOpts = {
        options = {
            highlights = require("catppuccin.groups.integrations.bufferline").get(),
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            close_command = function(n) require("mini.bufremove").delete(n, false) end,
            right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Title",
                    text_align = "left",
                },
            },
        },
    }
    require("bufferline").setup(bufferlineOpts)
end

--- @type LazyPluginSpec
M.pluginSpec = {
    "akinsho/bufferline.nvim",
    dependencies = {
        { "echasnovski/mini.bufremove", config = true, event = "VeryLazy" },
        { "catppuccin/nvim" },
    },
    config = configure,
    event = "VeryLazy",
    keys = {
        { "<leader>bp", function() vim.cmd.BufferLineTogglePin() end, desc = "Toggle pin" },
        { "<leader>bP", function() vim.cmd.BufferLineGroupClose("ungrouped") end, desc = "Delete non-pinned buffers" },
    },
}

return M
