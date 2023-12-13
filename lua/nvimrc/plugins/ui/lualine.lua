local function diff_source()
  -- This is defined by gitsigns
  ---@diagnostic disable-next-line: undefined-field
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  else
    return {}
  end
end

local language_server_ignore = { "efm", "null-ls", "copilot" }

local function lspName()
  local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
  clients = vim.tbl_filter(function(it)
    return not vim.tbl_contains(language_server_ignore, it.name)
  end, clients)
  local lspCount = vim.tbl_count(clients)
  local prefix = " "
  local content = "N/A"
  if lspCount == 0 then
    content = "N/A"
  elseif lspCount == 1 then
    content = clients[1].name
  else
    content = string.format("%s Language servers", lspCount)
  end
  return prefix .. content
end

local function configure()
  local help_extension = require("lualine.extensions.man")
  help_extension.filetypes = { "help" }
  help_extension.sections.lualine_a = { function() return "Help" end }

  local neo_test_extension = {
    sections = {
      lualine_a = { function() return "NeoTest" end },

      lualine_c = {
        { "filetype", icon_only = true,   separator = "", padding = { left = 1, right = 0 } },
        { "filename", file_status = false },
      },
    },
    filetypes = { "neotest-output-panel", "neotest-output", "neotest-summary" },
  }

  local saga_outline = require("lualine.extensions.man")
  saga_outline.filetypes = { "sagaoutline" }
  saga_outline.sections.lualine_a = { function() return "LSP Outline" end }
  saga_outline.sections.lualine_b = {}

  local lualineOptions = {
    options = {
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        { "mode", icons_enabled = true },
      },
      lualine_b = {
        "branch",
        { "diff", source = diff_source },
      },
      lualine_c = {
        { "filetype",    icon_only = true,               separator = "", padding = { left = 1, right = 0 } },
        {
          "filename",
          file_status = true,
          path = 0,
          shorting_target = 40,
          symbols = {
            modified = "•",
            readonly = " [Read Only]",
            unnamed = " [No Name]",
            new = " [New File]",
          },
        },
        { "diagnostics", sources = { "nvim_diagnostic" } },
      },
      lualine_x = {
        {
          function() return "  " .. require("dap").status() end,
          cond = function() return require("dap").status() ~= "" end,
        },
      },
      lualine_y = {
        "encoding",
        "location",
        "progress",
        {
          "fileformat",
          icons_enabled = true,
          symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
        },
      },
      lualine_z = {
        {
          lspName,
          on_click = function() vim.cmd.LspInfo() end,
        },
        {
          function() return require("copilot_status").status_string() end,
          cond = function() return require("copilot_status").enabled() end,
        },
      },
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
      help_extension,
      neo_test_extension,
      saga_outline,
    },
  }
  require("lualine").setup(lualineOptions)
end

local function configCopilotStatus()
  require("copilot_status").setup({
    icons = {
      idle = " ",
      error = " ",
      offline = " ",
      warning = " ",
      loading = "󰦗 ",
    },
  })
end

--- @type LazyPluginSpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    {
      "SmiteshP/nvim-navic",
      config = configNavic,
    },
    {
      "jonahgoldwastaken/copilot-status.nvim",
      dependencies = { "zbirenbaum/copilot.lua" },
      event = "BufReadPost",
      config = configCopilotStatus,
    },
  },
  config = configure,
  event = "VeryLazy",
}
