local lsp_server_opts = require("nvimrc.lsp").lsp_default_opts()
local rustacean_cfg = require("rustaceanvim.config.server")
lsp_server_opts.capabilities = vim.tbl_deep_extend(
  "force",
  lsp_server_opts.capabilities,
  rustacean_cfg.create_client_capabilities()
)

lsp_server_opts.settings = {
  init_options = {
    check = {
      command = "clippy",
      extraArgs = { "--no-deps" },
    },
    diagnostics = {
      experimental = {
        enabled = true,
      },
    },
  },
}

local executors = require("rustaceanvim.executors")
--- @type RustaceanConfig
local rust_config = {
  server = lsp_server_opts,
  tools = {
    executor = executors.toggleterm,
  },
}
vim.g.rustaceanvim = rust_config
