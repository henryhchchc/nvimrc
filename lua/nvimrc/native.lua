local M = {}

function M.setup(name, plugin, options, title, prepare)
  if plugin.library_available() then
    plugin.setup(options)
    return
  end
  local progress = require("fidget.progress").handle.create({
    title = title, lsp_client = { name = name }, cancellable = false,
  })
  require("blink.lib.task").resolve():map(prepare):schedule():map(function ()
    plugin.setup(options)
    progress.message = "Ready"
    progress:finish()
  end):catch(vim.schedule_wrap(function (err)
    progress.message = "Failed"
    progress:finish()
    vim.notify(name .. ": " .. tostring(err), vim.log.levels.ERROR)
  end))
end

return M
