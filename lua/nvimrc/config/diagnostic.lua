local diag_icons = { " ", " ", " ", "" }
local diag_highlights = { "DiagnosticSignError", "DiagnosticSignWarn", "DiagnosticSignHint", "DiagnosticSignInfo" }

for idx, hl in pairs(diag_highlights) do
  vim.fn.sign_define(hl, { text = diag_icons[idx], texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "if_many",
    severity = { min = vim.diagnostic.severity.INFO },
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "solid",
    severity_sort = true,
    format = function (diag)
      local source = diag.source
      if source and source:find("%.$") then source = source:gsub("%.", "") end
      return string.format("%s [%s] %s", diag_icons[diag.severity], source, diag.message)
    end,
  },
})
