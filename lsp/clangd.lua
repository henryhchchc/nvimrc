---@type vim.lsp.Config
return {
  cmd = { "clangd" },
  root_markers = { ".git/", ".clangd" },
  filetypes = { "c", "cpp", "cuda" },
}
