local function configure()
  local defaultOpts = require("nvimrc.lsp").lsp_default_opts()
  local clangdConfig = {
    capabilities = {
      offsetEncoding = "utf-8",
    },
  }
  local finalConfig = vim.tbl_deep_extend("force", defaultOpts, clangdConfig)
  require("clangd_extensions").setup({ server = finalConfig })
end

return {
  "p00f/clangd_extensions.nvim",
  ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  config = configure,
}
