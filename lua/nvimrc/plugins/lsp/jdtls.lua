local M = {}

function M.setup()
  local lsp_config = require("lspconfig")
  local default_opts = require("nvimrc.lsp").lsp_default_opts()
  local lsp_utls = require("lspconfig.util")
  local jdtls_cache_dir = lsp_utls.path.join(vim.loop.os_homedir(), ".cache", "jdtls")
  local config_dir = lsp_utls.path.join(jdtls_cache_dir, "config")
  local data_dir = lsp_utls.path.join(jdtls_cache_dir, "project_data", vim.fn.sha256(vim.loop.cwd() or ""))
  local extra_jdtls_config = {
    cmd = {
      "jdtls",
      "-configuration",
      config_dir,
      "-data",
      data_dir,
      "--jvm-arg=-XX:+UseZGC",
    },
    init_options = {
      workspace = config_dir,
      extendedClientCapabilities = {
        progressReportProvider = true,
      },
    },
    handlers = {
      ["$/progress"] = require("noice.lsp.progress").progress,
    },
  }
  local final_config = vim.tbl_deep_extend("force", default_opts, extra_jdtls_config)
  lsp_config.jdtls.setup(final_config)
end

return M
