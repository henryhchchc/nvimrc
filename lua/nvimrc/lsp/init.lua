local M = {}

function M.lsp_default_opts()
  local initial_caps = vim.lsp.protocol.make_client_capabilities()
  local capabilities = require("cmp_nvim_lsp").default_capabilities(initial_caps)
  local lspFlags = {}
  return {
    capabilities = capabilities,
    flags = lspFlags,
  }
end

function M.setup_with_default(server, settings)
  local lspConfig = require("lspconfig")
  local options = M.lsp_default_opts()
  options.settings = settings or {}
  lspConfig[server].setup(options)
end

return M
