local language_server_ignore = { "null-ls", "copilot", "typos_lsp" }

local function get_attached_lsps()
  local bufnr = vim.api.nvim_get_current_buf()
  return vim.iter(vim.lsp.get_clients({ bufnr = bufnr }))
    :filter(function (client)
      return not vim.list_contains(language_server_ignore, client.name)
    end)
    :totable()
end

local function lsp_name()
  local clients = get_attached_lsps()
  local lsp_count = #clients
  local prefix = " "
  local content = "!"
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

return {
  lsp_name,
  on_click = function ()
    vim.cmd.LspInfo()
  end,
  cond = has_lsp_attached,
}
