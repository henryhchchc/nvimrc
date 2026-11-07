local M = {}

function M.setup()
  require("fidget").setup()
  vim.notify = require("fidget.notification").notify
end

return M
