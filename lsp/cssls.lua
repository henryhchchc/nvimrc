---@type vim.lsp.Config
return {
  cmd = { "vscode-css-languageserver", "--stdio" },
  filetypes = { "css", "scss", "less" },
}
