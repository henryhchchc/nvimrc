local function generate_options()
  local exts = require("nvimrc.lazy_plugins.ui.lualine.extensions")
  local format = {
    "fileformat",
    icons_enabled = true,
    symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
  }

  return {
    options = {
      theme = "catppuccin",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
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
        {
          function () return "  " .. require("dap").status() end,
          cond = function () return require("dap").status() ~= "" end,
        },
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
      "nvim-dap-ui",
      "neo-tree",
      "quickfix",
      "aerial",
      "lazy",
      "trouble",
      "fugitive",
      "toggleterm",
      exts.help,
      exts.neotest,
      exts.saga_outline,
    },
  }
end


--- @type LazyPluginSpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    {
      "AndreM222/copilot-lualine",
      dependencies = { "zbirenbaum/copilot.lua" },
    },
  },
  opts = generate_options,
  event = "VeryLazy",
}
