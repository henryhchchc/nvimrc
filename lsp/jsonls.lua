---@type vim.lsp.Config
return {
  cmd = { "vscode-json-languageserver", "--stdio" },
  filetypes = { "json" },
  settings = {
    json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
  },
}
