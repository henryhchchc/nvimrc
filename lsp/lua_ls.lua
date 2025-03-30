--- @type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  root_markers = { ".git/", ".luarc.json" },
  filetypes = { "lua" },
}
