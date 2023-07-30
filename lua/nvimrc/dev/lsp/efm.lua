local M = {}

local efm_filetypes = {
  "css",
  "html",
  "javascript",
  "typescript",
  "typescript",
  "graphql",
  "python",
  "yaml",
  "json",
}

function M.configure(defaultOpts)
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
end

return M
