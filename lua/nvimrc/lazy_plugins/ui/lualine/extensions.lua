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

M.autoformat = {
  function () return "󰁨 " end,
  cond = function () return vim.b.autoformat end,
}

M.lsp = require("nvimrc.lazy_plugins.ui.lualine.lsp_status")

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
      { "filename", file_status = false, path = 0 },
    },
    lualine_x = { "progress" },
    lualine_z = { "filesize" },
  },
}

-- HACK: The type annotation provided by Noice is incorrect
--- @class NoiceStatus
--- @field get fun():string
--- @field has fun():boolean

--- @type table<string, NoiceStatus>
local noice_status = require("noice").api.status

M.noice_mode = {
  noice_status.mode.get,
  cond = noice_status.mode.has,
}

M.noice_cmd = {
  noice_status.command.get,
  cond = noice_status.command.has,
}

M.noice_message = {
  noice_status.message.get,
  cond = noice_status.message.has,
}

M.noice_search = {
  noice_status.search.get,
  cond = noice_status.search.has,
}

local wordcount_fts = {
  "markdown",
  "text",
}

M.word_count = {
  function ()
    if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "" then
      return string.format(" %d (sel)", vim.fn.wordcount().visual_words)
    else
      return string.format(" %d", vim.fn.wordcount().words)
    end
  end,
  cond = function ()
    return vim.tbl_contains(wordcount_fts, vim.bo.filetype)
  end,
}

return M
