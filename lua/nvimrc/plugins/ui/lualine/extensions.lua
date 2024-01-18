local M = {}

M.neotest = {
  sections = {
    lualine_a = { function () return "NeoTest" end },
    lualine_c = {
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      { "filename", file_status = false },
    },
  },
  filetypes = { "neotest-output-panel", "neotest-output", "neotest-summary" },
}

M.copilot = {
  function () return require("copilot_status").status_string() end,
  cond = function () return require("copilot_status").enabled() end,
}

M.lsp = require("nvimrc.plugins.ui.lualine.lsp_status")

M.saga_outline = {
  filetypes = { "sagaoutline" },
  sections = {
    lualine_a = { function () return "LSP Symbols" end },
    lualine_b = {},
  },
}

M.help = {
  filetypes = { "help" },
  sections = {
    lualine_a = { function () return "Help" end },
    lualine_b = {
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      {
        "filename",
        file_status = false,
        path = 0,
      },
    },
  },
}


return M
