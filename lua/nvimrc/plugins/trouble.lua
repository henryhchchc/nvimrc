return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "TroubleToggle", "Trouble" },
  keys = {
    {
      "<leader>xd",
      function () vim.cmd.TroubleToggle("document_diagnostics") end,
      desc = "Document Diagnostics (Trouble)",
    },
    {
      "<leader>xx",
      function () vim.cmd.TroubleToggle("workspace_diagnostics") end,
      desc = "Workspace Diagnostics (Trouble)",
    },
    { "<leader>xl", function () vim.cmd.TroubleToggle("loclist") end, desc = "Location List (Trouble)" },
    { "<leader>xq", function () vim.cmd.TroubleToggle("quickfix") end, desc = "Quickfix List (Trouble)" },
  },
  config = true,
}
