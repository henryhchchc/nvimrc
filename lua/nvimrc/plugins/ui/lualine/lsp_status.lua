local language_server_ignore = { "null-ls", "copilot" }

local function get_attached_lsps()
  local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  clients = vim.tbl_filter(function (it) return not vim.tbl_contains(language_server_ignore, it.name) end, clients)
  return clients
end

local function lsp_name()
  local clients = get_attached_lsps()
  local lsp_count = vim.tbl_count(clients)
  local prefix = " "
  local content = "!"
  if lsp_count == 1 then
    content = clients[1].name
  else
    content = string.format("%s Language servers", lsp_count)
  end
  return prefix .. content
end

local function has_lsp_attached()
  local clients = get_attached_lsps()
  return not vim.tbl_isempty(clients)
end

return {
  lsp_name,
  on_click = function () vim.cmd.LspInfo() end,
  cond = has_lsp_attached,
}
