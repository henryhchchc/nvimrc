local function config_lsp(_plugin, _opts)
  local attach = require("nvimrc.lsp.attach")

  require("nvimrc.config.diagnostic")

  attach.setup()

  vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  })

  vim.lsp.enable(require("nvimrc.lsp.servers"))
end

local event = require("nvimrc.utils").deferred_event()

--- @type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  -- nvim-lspconfig only provides server configs. The vim.lsp.enable() call in
  -- config_lsp is what starts clients: directly for already-open buffers, or
  -- later on FileType. Dependencies load before config, so this guarantees
  -- blink.cmp (whose capabilities config_lsp uses) and schemastore (required by
  -- jsonls' server config) are both loaded before any client starts.
  dependencies = { "saghen/blink.cmp", "b0o/schemastore.nvim" },
  event = event,
  config = config_lsp,
}
