---@type vim.lsp.Config
return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = { "tsconfig.json", "jsconfig.json", ".git" },
}
