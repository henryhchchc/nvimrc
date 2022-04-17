local M = {}

--- @param option string
--- @param silent false?
--- @param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    vim.notify("Set " .. option .. " to " .. vim.opt_local[option]:get(), vim.log.levels.INFO, { title = "Option" })
    return
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      vim.notify("Enabled " .. option, vim.log.levels.INFO, { title = "Option" })
    else
      vim.notify("Disabled " .. option, vim.log.levels.INFO, { title = "Option" })
    end
  end
end

--- @param option string
--- @param silent false?
--- @param values? {[1]:any, [2]:any}
function M.toggle_buf_var(option, silent, values)
  if values then
    if vim.b[option] == values[1] then
      vim.b[option] = values[2]
    else
      vim.b[option] = values[1]
    end
    vim.notify("Set " .. option .. " to " .. vim.b[option], vim.log.levels.INFO, { title = "Option" })
    return
  end
  vim.b[option] = not vim.b[option]
  if not silent then
    if vim.b[option] then
      vim.notify("Enabled " .. option, vim.log.levels.INFO, { title = "Option" })
    else
      vim.notify("Disabled " .. option, vim.log.levels.INFO, { title = "Option" })
    end
  end

end

return M
