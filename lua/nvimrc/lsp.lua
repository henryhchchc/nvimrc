local attach = require("nvimrc.lsp.attach")

local M = {
  servers = require("nvimrc.lsp.servers"),
  on_attach = attach.on_attach,
}

return M
