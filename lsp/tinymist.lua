---@type vim.lsp.Config
return {
  settings = {
    exportPdf = "onSave",
    formatterMode = "typstyle",
    lint = {
      enabled = true,
    },
    outputPath = "$root/$name",
    syntaxOnly = "disable",
  },
}
