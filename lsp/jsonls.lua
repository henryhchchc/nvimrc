---@type vim.lsp.Config
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json" },
  settings = {
    json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
  },
}
