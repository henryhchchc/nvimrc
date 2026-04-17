local attach = require("nvimrc.lsp.attach")

local M = {
  capabilities = require("nvimrc.lsp.capabilities"),
  servers = require("nvimrc.lsp.servers"),
  on_attach = attach.on_attach,
}

return M
