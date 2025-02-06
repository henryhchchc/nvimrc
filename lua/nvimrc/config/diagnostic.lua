local diag_icons = {
  [vim.diagnostic.severity.ERROR] = "",
  [vim.diagnostic.severity.WARN] = "",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = "",
}

--- @type vim.diagnostic.SeverityFilter
local warn_or_above = { min = vim.diagnostic.severity.WARN }

vim.diagnostic.config({
  virtual_text = false,
  -- virtual_text = {
  --   prefix = function (it) return diag_icons[it.severity] or "●" end,
  --   source = "if_many",
  --   severity = warn_or_above,
  -- },
  signs = { text = diag_icons },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    severity_sort = true,
    format = function (diag)
      local source = diag.source
      if source and source:find("%.$") then source = source:gsub("%.", "") end
      return string.format("%s [%s] %s", diag_icons[diag.severity], source, diag.message)
    end,
  },
})
