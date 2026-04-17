local function config_lsp(_plugin, _opts)
  local lsp = require("nvimrc.lsp")

  vim.lsp.config("*", {
    on_attach = lsp.on_attach,
    capabilities = lsp.capabilities.create(),
  })

  vim.lsp.enable(lsp.servers)
end

--- @type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  config = config_lsp,
}
