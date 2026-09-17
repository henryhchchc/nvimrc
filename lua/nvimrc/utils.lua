local M = {}

local function notify(message)
  vim.notify(message, vim.log.levels.INFO, { title = "Option" })
end

--- @param option string
--- @param silent boolean?
--- @param values? {[1]:any, [2]:any}
--- @param read fun(option: string): any
--- @param write fun(option: string, value: any)
local function toggle(option, silent, values, read, write)
  if values then
    if read(option) == values[1] then
      write(option, values[2])
    else
      write(option, values[1])
    end
    if not silent then
      notify("Set " .. option .. " to " .. tostring(read(option)))
    end
    return
  end

  write(option, not read(option))
  if not silent then
    notify((read(option) and "Enabled " or "Disabled ") .. option)
  end
end

--- Toggle a buffer/window-local option. With `values`, flip between
--- `values[1]` and `values[2]`; without, flip between true and false.
--- @param option string
--- @param silent boolean?
--- @param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  toggle(option, silent, values, function (name)
    return vim.opt_local[name]:get()
  end, function (name, value)
    vim.opt_local[name] = value
  end)
end

--- Same as `M.toggle`, for a buffer variable in `vim.b`.
--- @param option string
--- @param silent boolean?
--- @param values? {[1]:any, [2]:any}
function M.toggle_buf_var(option, silent, values)
  toggle(option, silent, values, function (name)
    return vim.b[name]
  end, function (name, value)
    vim.b[name] = value
  end)
end

--- Event that defers a plugin's load until after startup when a UI is
--- present. VeryLazy is emitted on UIEnter, which never happens headless, so
--- headless falls back to reading a buffer.
--- @return string|string[]
function M.deferred_event()
  return require("lazy.core.config").headless() and { "BufReadPre", "BufNewFile" } or "VeryLazy"
end

return M
