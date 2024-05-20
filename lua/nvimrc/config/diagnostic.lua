local diag_icons = {
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN] = " ",
  [vim.diagnostic.severity.INFO] = " ",
  [vim.diagnostic.severity.HINT] = "",
}

for severity, icon in pairs(diag_icons) do
  local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
  name = "DiagnosticSign" .. name
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end

local function diag_prefix(diagnostic)
  for severity, icon in pairs(diag_icons) do
    if diagnostic.severity == severity then
      return icon
    end
  end
  return "●"
end


vim.diagnostic.config({
  virtual_text = {
    prefix = diag_prefix,
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

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function ()
    vim.cmd.Lspsaga("show_cursor_diagnostics", "++unfocus")
  end,
})
