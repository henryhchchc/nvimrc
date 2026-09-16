-- Completion capabilities that blink.cmp advertises on top of Neovim's
-- defaults. Hardcoded so that resolving/starting LSP clients does not require
-- loading blink.cmp first. Keep in sync with blink.cmp's
-- get_lsp_capabilities() when upgrading (this mirrors v2's static table).
local blink_capabilities = {
  textDocument = {
    completion = {
      insertTextMode = 1,
      completionItem = {
        insertTextModeSupport = { valueSet = { 1 } },
        resolveSupport = {
          properties = { "documentation", "detail", "additionalTextEdits", "command", "data" },
        },
      },
      completionList = {
        itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" },
      },
    },
  },
}

local function config_lsp(_plugin, _opts)
  local lsp = require("nvimrc.lsp")

  require("nvimrc.config.diagnostic")

  vim.lsp.config("*", {
    on_attach = lsp.on_attach,
    capabilities = blink_capabilities,
  })

  vim.lsp.enable(lsp.servers)
end

-- Defer until after startup when a UI is present. VeryLazy is emitted on
-- UIEnter, which never happens headless, so fall back to reading a buffer.
local event = require("lazy.core.config").headless()
    and { "BufReadPre", "BufNewFile" }
  or "VeryLazy"

--- @type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  -- nvim-lspconfig only provides server configs. The vim.lsp.enable() call in
  -- config_lsp is what starts clients: directly for already-open buffers, or
  -- later on FileType. Dependencies load before config, so this guarantees
  -- blink.cmp is set up (and its capability registration has run) before any
  -- client starts. Both plugins share the same event, so be explicit.
  dependencies = { "saghen/blink.cmp" },
  event = event,
  config = config_lsp,
}
