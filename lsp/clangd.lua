---@type vim.lsp.Config
return {
  cmd = { "clangd", "--offset-encoding=utf-8" },
  root_markers = { ".git/", ".clangd" },
  filetypes = { "c", "cpp" },
}
