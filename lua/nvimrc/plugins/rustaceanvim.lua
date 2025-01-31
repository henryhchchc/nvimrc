local lsp_server_opts = require("nvimrc.lsp").lsp_default_opts()
local rustacean_cfg = require("rustaceanvim.config.server")
lsp_server_opts.capabilities = vim.tbl_deep_extend(
  "force",
  lsp_server_opts.capabilities,
  rustacean_cfg.create_client_capabilities()
)

local default_on_attach = lsp_server_opts.on_attach

local function lsp_on_attach(client, bufnr)
  default_on_attach(client, bufnr)

  local function rustLsp(args)
    return function ()
      vim.cmd.RustLsp(args)
    end
  end

  vim.keymap.set("n", "g.", rustLsp("codeAction"), { desc = "LSP Code Actions", buffer = bufnr })
  vim.keymap.set("n", "gX", rustLsp("openDocs"), { desc = "Open docs.rs", buffer = bufnr })
  vim.keymap.set("n", "K", rustLsp({ "hover", "actions" }), { desc = "LSP Hover", buffer = bufnr })
  vim.keymap.set("n", "J", rustLsp("joinLines"), { desc = "Rust Join Lines", buffer = bufnr })
end

lsp_server_opts.on_attach = lsp_on_attach

lsp_server_opts.init_options = {
  check = {
    command = "clippy",
    extraArgs = { "--no-deps" },
  },
  diagnostics = {
    experimental = {
      enabled = true,
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
