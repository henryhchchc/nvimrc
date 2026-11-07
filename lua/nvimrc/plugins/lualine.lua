local language_server_ignore = { "typos_lsp" }

local function get_attached_lsps()
  local bufnr = vim.api.nvim_get_current_buf()
  local function is_not_ignored(client)
    return not vim.list_contains(language_server_ignore, client.name)
  end
  return vim.iter(vim.lsp.get_clients({ bufnr = bufnr })):filter(is_not_ignored):totable()
end

local function lsp_name()
  local clients = get_attached_lsps()
  local lsp_count = #clients
  local prefix = " "
  local content
  if lsp_count == 1 then
    content = clients[1].name
  elseif lsp_count == 2 then
    content = string.format("%s & %s", clients[1].name, clients[2].name)
  else
    content = string.format("%s LSP Servers", lsp_count)
  end
  return prefix .. content
end

local function has_lsp_attached()
  return #get_attached_lsps() > 0
end

local lsp_status = {
  lsp_name,
  on_click = function ()
    vim.cmd.LspInfo()
  end,
  cond = has_lsp_attached,
}

local exts = {}

exts.autoformat = {
  function ()
    return "󰁨 "
  end,
  cond = function ()
    return vim.b.autoformat
  end,
}

exts.lsp = lsp_status

exts.help = {
  filetypes = { "help" },
  sections = {
    lualine_a = {
      function ()
        return "Help"
      end,
    },
    lualine_b = {
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      { "filename", file_status = false, path = 0 },
    },
    lualine_x = { "progress" },
    lualine_z = { "filesize" },
  },
}

local wordcount_fts = {
  "markdown",
  "text",
}

exts.word_count = {
  function ()
    if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "" then
      return string.format(" %d (sel)", vim.fn.wordcount().visual_words)
    else
      return string.format(" %d", vim.fn.wordcount().words)
    end
  end,
  cond = function ()
    return vim.list_contains(wordcount_fts, vim.bo.filetype)
  end,
}


local lualine_options = {
  options = {
    theme = "catppuccin-nvim",
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
        newfile_status = true,
        path = 4,
        shorting_target = 40,
        symbols = {
          modified = "•",
          readonly = "",
          unnamed = " [No Name]",
          newfile = " [New File]",
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
    },
    lualine_z = { exts.lsp },
  },
  extensions = {
    "man",
    "neo-tree",
    "quickfix",
    "fugitive",
    "oil",
    exts.help,
  },
}

require("lualine").setup(lualine_options)
