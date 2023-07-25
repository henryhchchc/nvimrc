local M = {}

function M.configure(defaultOpts)
  local additionalOpts = {
    filetypes = { "python" },
  }
  local options = vim.tbl_deep_extend("force", defaultOpts, additionalOpts)
  require("lspconfig").efm.setup(options)
end

return M
