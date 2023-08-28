local efm_filetypes = {
  "css",
  "html",
  "markdown",
  "javascript",
  "typescript",
  "graphql",
  "yaml",
  "json",
}

local defaultOpts = require("nvimrc.lsp").lsp_default_opts()

local additionalOpts = {
  init_options = {
    documentRangeFormatting = true,
    documentFormatting = true,
    hover = true,
    codeAction = true,
    completion = true,
  },
  filetypes = efm_filetypes,
}
local options = vim.tbl_deep_extend("force", defaultOpts, additionalOpts)
require("lspconfig").efm.setup(options)
