---@class nvimrc.NativePlugin<Options>
---@field library_available fun(): boolean
---@field setup fun(options: Options)

---@class nvimrc.Native
local M = {}

---@generic Options, Result
---@param name string
---@param plugin nvimrc.NativePlugin<Options>
---@param options Options
---@param title string
---@param prepare fun(): blink.lib.Task<Result>
function M.setup(name, plugin, options, title, prepare)
  if plugin.library_available() then
    plugin.setup(options)
    return
  end
  local progress = { kind = "progress", source = name, title = title, status = "running" }
  progress.id = vim.api.nvim_echo({ { "Starting" } }, true, progress)
  require("blink.lib.task").resolve():map(prepare):schedule():map(function ()
    plugin.setup(options)
    progress.status = "success"
    vim.api.nvim_echo({ { "Ready" } }, true, progress)
  end):catch(vim.schedule_wrap(function (err)
    progress.status = "failed"
    vim.api.nvim_echo({ { "Failed" } }, true, progress)
    vim.notify(name .. ": " .. tostring(err), vim.log.levels.ERROR)
  end))
end

return M
