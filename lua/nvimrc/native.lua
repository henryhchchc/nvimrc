local M = {}

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
