local function lsp_on_attach(client, bufnr)
  local on_attach = vim.lsp.config["*"].on_attach or function (_, _) end
  on_attach(client, bufnr)
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

local rustacean_cfg = require("rustaceanvim.config.server")

local executors = require("rustaceanvim.executors")
--- @type rustaceanvim.Opts
local rust_config = {
  tools = {
    executor = executors.toggleterm,
  },
}
vim.g.rustaceanvim = rust_config

---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  on_attach = lsp_on_attach,
  capabilities = rustacean_cfg.create_client_capabilities(),
  before_init = nil,
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
