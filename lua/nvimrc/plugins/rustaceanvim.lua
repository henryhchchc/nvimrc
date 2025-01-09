local lsp_default_opts = require("nvimrc.lsp").lsp_default_opts()
local rustacean_cfg = require("rustaceanvim.config.server")
lsp_default_opts.capabilities = vim.tbl_deep_extend(
  "force",
  lsp_default_opts.capabilities,
  rustacean_cfg.create_client_capabilities()
)
local executors = require("rustaceanvim.executors")
--- @type RustaceanConfig
local rust_config = {
  server = lsp_default_opts,
  tools = {
    executor = executors.toggleterm,
  },
}
vim.g.rustaceanvim = rust_config
