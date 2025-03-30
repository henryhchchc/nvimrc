---@type vim.lsp.Config
return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml" },
  settings = {
    yaml = { schemaStore = { enable = true } },
  },
}
