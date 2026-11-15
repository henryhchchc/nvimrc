local statusline = require("mini.statusline")

local function lsp_status()
  local clients = vim.iter(vim.lsp.get_clients({ bufnr = 0 }))
      :filter(function (client) return client.name ~= "typos_lsp" end)
      :map(function (client) return client.name end)
      :totable()
  if #clients == 0 then
    return ""
  end
  local names = #clients <= 2 and table.concat(clients, " & ") or string.format("%d LSP Servers", #clients)
  return "%@v:lua.NvimrcStatuslineLspClick@ " .. names:gsub("%%", "%%%%") .. "%X"
end

function _G.NvimrcStatuslineLspClick()
  vim.cmd.LspInfo()
end

local function autoformat_status()
  return require("nvimrc.config.lsp").can_format(vim.api.nvim_get_current_buf()) and "󰁨" or ""
end

local function word_count()
  if not vim.list_contains({ "markdown", "text" }, vim.bo.filetype) then
    return ""
  end
  local mode = vim.fn.mode()
  local count = vim.fn.wordcount()
  if mode == "v" or mode == "V" or mode == "\22" then
    return string.format(" %d (sel)", count.visual_words)
  end
  return string.format(" %d", count.words)
end

statusline.setup({
  content = {
    active = function ()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      return statusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        {
          hl = "MiniStatuslineDevinfo",
          strings = {
            statusline.section_git({ trunc_width = 40 }),
            statusline.section_diff({ trunc_width = 75 }),
            statusline.section_diagnostics({ trunc_width = 75 }),
          },
        },
        "%<",
        { hl = "MiniStatuslineFilename", strings = { statusline.section_filename({ trunc_width = 140 }) } },
        "%=",
        {
          hl = "MiniStatuslineFileinfo",
          strings = {
            autoformat_status(),
            word_count(),
            statusline.section_fileinfo({ trunc_width = 120 }),
            "%l:%c",
          },
        },
        { hl = mode_hl, strings = { lsp_status() } },
      })
    end,
  },
})
