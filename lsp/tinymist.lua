---@type vim.lsp.Config
return {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  init_options = {
    exportPdf = "onDocumentHasTitle",
    outputPath = "$root/$name",
    formatterMode = "typstyle",
  },
}
