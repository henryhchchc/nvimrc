local diag_icons = {
  [vim.diagnostic.severity.ERROR] = "",
  [vim.diagnostic.severity.WARN] = "",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = "",
}

--- @param _ vim.Diagnostic?
--- @param bufnr integer
local function on_jump(_, bufnr)
  vim.diagnostic.open_float({ bufnr = bufnr })
end

vim.diagnostic.config({
  signs = { text = diag_icons },
  jump = { on_jump = on_jump },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = {
    severity = vim.diagnostic.severity.INFO,
  },
  float = {
    severity_sort = true,
    format = function (diag)
      local source = diag.source
      if source and source:find("%.$") then
        source = source:gsub("%.", "")
      end
      return string.format("%s [%s] %s", diag_icons[diag.severity], source, diag.message)
    end,
  },
})
