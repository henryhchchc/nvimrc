local M = {}

local function configure()
  local defaultOpts = require("nvimrc.dev.lsp").makeDefaultOpts()
  local clangdConfig = {
    capabilities = {
      offsetEncoding = "utf-8",
    },
  }
  local finalConfig = vim.tbl_deep_extend("force", defaultOpts, clangdConfig)
  require("clangd_extensions").setup({ server = finalConfig })
end

M.pluginSpec = {
  "p00f/clangd_extensions.nvim",
  ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  config = configure,
}

return M
