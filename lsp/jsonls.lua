---@type vim.lsp.Config
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  before_init = function (_, config)
    config.settings.json.schemas = require("schemastore").json.schemas()
  end,
  settings = {
    json = { validate = { enable = true } },
  },
}
