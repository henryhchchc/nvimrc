---@type vim.lsp.Config
return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  settings = {
    html = {
      suggest = { html5 = true },
    },
  },
}
