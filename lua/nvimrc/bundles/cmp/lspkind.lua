local M = {}

--- @type table<string, string>
local sourceNames = {
  buffer = "Buf",
  nvim_lsp = "LSP",
  cmdline = "Cmd",
  path = "Path",
}

M.options = {
  mode = "symbol",
  maxwidth = 50,
  ellipsis_char = "...",
  ---@param entry cmp.Entry
  ---@param vim_item vim.CompletedItem
  ---@return vim.CompletedItem
  before = function (entry, vim_item)
    local sourceName = sourceNames[entry.source.name] or entry.source.name
    if entry.source.name == "nvim_lsp" then
      local client = entry.source.source.client or {}
      sourceName = string.format("LSP: %s", client.name)
    end
    vim_item.menu = sourceName
    return vim_item
  end,
  symbol_map = {
    Copilot = "",
  },
}

return M
