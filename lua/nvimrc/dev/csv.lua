local M = {}

--- @type LazyPluginSpec
M.pluginSpec = {
  "cameron-wags/rainbow_csv.nvim",
  config = true,
  ft = {
    "csv",
    "tsv",
    "csv_semicolon",
    "csv_whitespace",
    "csv_pipe",
    "rfc_csv",
    "rfc_semicolon",
  },
}

return M
