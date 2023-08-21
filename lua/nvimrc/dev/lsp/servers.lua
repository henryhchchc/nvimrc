local M = {}

function M.setupRustAnalyzer()
  local defaultOpts = require("nvimrc.dev.lsp").makeDefaultOpts()
  local rustConfig = {
    server = defaultOpts,
    dap = {
      adapter = {
        type = "executable",
        command = "lldb-vscode",
        name = "rt_lldb",
      },
    },
  }
  require("rust-tools").setup(rustConfig)
end

function M.setupWithDefault(server, settings)
  local lspConfig = require("lspconfig")
  local options = require("nvimrc.dev.lsp").makeDefaultOpts()
  options.settings = settings or {}
  lspConfig[server].setup(options)
end

function M.setupDefaults(serversToConfigure)
  for _, lsp in pairs(serversToConfigure) do
    M.setupWithDefault(lsp, {})
  end
end

return M
