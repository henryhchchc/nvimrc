---@type vim.lsp.Config
return {
  cmd = { "sourcekit-lsp" },
  filetypes = { "swift", "objc", "objcpp" },
  root_markers = { ".git/", "Package.swift" },
}
