local M = {}

--- @type LazyPluginSpec
M.pluginSpec = {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
        {
            "<leader>xx",
            function() vim.cmd.TroubleToggle("document_diagnostics") end,
            desc = "Document Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            function() vim.cmd.TroubleToggle("workspace_diagnostics") end,
            desc = "Workspace Diagnostics (Trouble)",
        },
        { "<leader>xL", function() vim.cmd.TroubleToggle("loclist") end, desc = "Location List (Trouble)" },
        { "<leader>xQ", function() vim.cmd.TroubleToggle("quickfix") end, desc = "Quickfix List (Trouble)" },
    },
    config = true,
}

return M
