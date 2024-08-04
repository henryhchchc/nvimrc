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
  --   severity = { min = vim.diagnostic.severity.ERROR },
  -- },
  signs = { text = diag_icons },
  underline = { severity = warn_or_above },
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    severity_sort = true,
    format = function (diag)
      local source = diag.source
      if source and source:find("%.$") then source = source:gsub("%.", "") end
      return string.format("%s [%s] %s", diag_icons[diag.severity], source, diag.message)
    end,
  },
})
