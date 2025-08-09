---@type vim.lsp.Config
return {
  init_options = {
    exportPdf = "onDocumentHasTitle",
    outputPath = "$root/$name",
    formatterMode = "typstyle",
  },
}
