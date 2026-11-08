---@type vim.lsp.Config
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  before_init = function (_, config)
    local settings = assert(config.settings)
    ---@cast settings lspconfig.settings.jsonls
    local json = assert(settings.json)
    json.schemas = require("schemastore").json.schemas()
  end,
  settings = {
    json = { validate = { enable = true } },
  },
}
