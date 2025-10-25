local exts = require("nvimrc.plugins.lualine.extensions")
local format = {
  "fileformat",
  icons_enabled = true,
  symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
}

local lualine_options = {
  options = {
    theme = "catppuccin",
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = {
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      {
        "filename",
        file_status = true,
        new_file_status = true,
        path = 1,
        shorting_target = 40,
        symbols = {
          modified = "•",
          readonly = "",
          unnamed = " [No Name]",
          new = " [New File]",
        },
      },
      { "diagnostics", sources = { "nvim_diagnostic" } },
    },
    lualine_x = {
      exts.autoformat,
    },
    lualine_y = {
      "location",
      exts.word_count,
      "filesize",
      "filetype",
      "encoding",
      format,
    },
    lualine_z = { exts.lsp, "copilot" },
  },
  extensions = {
    "man",
    "neo-tree",
    "quickfix",
    "lazy",
    "fugitive",
    "toggleterm",
    "oil",
    exts.help,
    -- exts.neotest,
  },
}

--- @type LazyPluginSpec
return {
  "nvim-lualine/lualine.nvim",
  version = "*",
  opts = lualine_options,
}
