local M = {}

function M.setup()
  local attach = require("nvimrc.lsp.attach")

  require("nvimrc.config.diagnostic")

  attach.setup()

  vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  })

  vim.lsp.enable(require("nvimrc.lsp.servers"))
end

return M
