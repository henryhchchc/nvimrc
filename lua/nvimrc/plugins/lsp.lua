local function config_lsp(_plugin, _opts)
  local lsp = require("nvimrc.lsp")

  vim.lsp.config("*", {
    on_attach = lsp.on_attach,
  })

  vim.lsp.enable(lsp.servers)
end

-- With a UI, load after startup (VeryLazy) so resolving every server config
-- stays off the startup path. Headless has no UIEnter, so VeryLazy never
-- fires there; fall back to loading when a buffer is read.
local event = require("lazy.core.config").headless()
    and { "BufReadPre", "BufNewFile" }
  or "VeryLazy"

--- @type LazyPluginSpec
return { "neovim/nvim-lspconfig", event = event, config = config_lsp }
