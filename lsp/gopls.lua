---@type vim.lsp.Config
return {
  cmd = { "gopls", "serve" },
  filetypes = { "go" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
