local defaultOpts = require("nvimrc.lsp").lsp_default_opts()

local lspUtil = require("lspconfig.util")
local jdtlsCacheDir = lspUtil.path.join(vim.loop.os_homedir(), ".cache", "jdtls")
local configDir = lspUtil.path.join(jdtlsCacheDir, "config")
local dataDir = lspUtil.path.join(jdtlsCacheDir, "project_data", vim.fn.sha256(vim.loop.cwd() or ""))
local extraJdtLsConfig = {
  cmd = {
    "jdtls",
    "-configuration",
    configDir,
    "-data",
    dataDir,
    "--jvm-arg=-XX:+UseZGC",
  },
  init_options = {
    workspace = configDir,
    extendedClientCapabilities = {
      progressReportProvider = true,
    },
  },
  handlers = {
    ["$/progress"] = require("noice.lsp.progress").progress,
  },
}
local finalConfig = vim.tbl_deep_extend("force", defaultOpts, extraJdtLsConfig)

local lspConfig = require("lspconfig")
lspConfig.jdtls.setup(finalConfig)
