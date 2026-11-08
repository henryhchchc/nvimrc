local language_server_ignore = { "typos_lsp" }

---@return vim.lsp.Client[]
local function get_attached_lsps()
  local bufnr = vim.api.nvim_get_current_buf()
  ---@param client vim.lsp.Client
  ---@return boolean
  local function is_not_ignored(client)
    return not vim.list_contains(language_server_ignore, client.name)
  end
  return vim.iter(vim.lsp.get_clients({ bufnr = bufnr })):filter(is_not_ignored):totable()
end

---@return string
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

---@return boolean
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
    return require("nvimrc.config.lsp").can_format(vim.api.nvim_get_current_buf())
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
      { "filename", file_status = false },
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
    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" or mode == "\22" then
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
    lualine_b = {
      "branch",
      {
        "diff",
        source = function ()
          local status = vim.b.gitsigns_status_dict
          if status then
            return { added = status.added, modified = status.changed, removed = status.removed }
          end
        end,
      },
    },
    lualine_c = {
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      {
        "filename",
        newfile_status = true,
        path = 4,
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
    "quickfix",
    "oil",
    exts.help,
  },
}

require("lualine").setup(lualine_options)
