---@type vim.lsp.Config
return {
  cmd = { "vscode-html-languageserver", "--stdio" },
  filetypes = { "html" },
  settings = {
    html = {
      suggest = { html5 = true },
    },
  },
}
