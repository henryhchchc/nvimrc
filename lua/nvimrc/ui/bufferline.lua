local M = {}


--- @type bufferline.UserConfig
local bufferlineOpts = {
    options = {
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
    }
}

--- @type LazyPluginSpec
M.pluginSpec = {
    "akinsho/bufferline.nvim",
    dependencies = {
        { "echasnovski/mini.bufremove" }
    },
    opts = bufferlineOpts,
    event = "VeryLazy",
    keys = {
        { "<leader>bp", function() vim.cmd.BufferLineTogglePin() end, desc = "Toggle pin" },
        { "<leader>bP", function() vim.cmd.BufferLineGroupClose("ungrouped") end, desc = "Delete non-pinned buffers" },
    }
}


return M
