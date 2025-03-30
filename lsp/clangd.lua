---@type vim.lsp.Config
return {
  cmd = { "clangd", "--background-index", "--offset-encoding=utf-8" },
  root_markers = { ".git/", "compile_commands.json", ".clangd" },
  filetypes = { "c", "cpp" },
}
