---@type vim.lsp.Config
return {
  cmd = { "pylsp" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "requirements.txt" },
}
