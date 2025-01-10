local M = {}

local utils = require("nvimrc.utils")

local function jdtls_progress_report(_, result, ctx)
  local info = { client_id = ctx.client_id }

  local kind = "report"
  if result.complete then
    kind = "end"
  elseif result.workDone == 0 then
    kind = "begin"
  elseif result.workDone > 0 and result.workDone < result.totalWork then
    kind = "report"
  else
    kind = "end"
  end

  local percentage = 0
  if result.totalWork > 0 and result.workDone >= 0 then
    percentage = result.workDone / result.totalWork * 100
  end

  local msg = {
    token = result.id,
    value = {
      kind = kind,
      percentage = percentage,
      title = result.subTask,
      message = result.subTask,
    },
  }
  vim.lsp.handlers[vim.lsp.protocol.Methods.dollar_progress](nil, msg, info)
end

function M.setup()
  local lsp_config = require("lspconfig")
  local default_opts = require("nvimrc.lsp").lsp_default_opts()
  local jdtls_cache_dir = utils.concat_paths(vim.uv.os_homedir(), ".cache", "jdtls")
  local config_dir = utils.concat_paths(jdtls_cache_dir, "config")
  local data_dir = utils.concat_paths(jdtls_cache_dir, "project_data", vim.fn.sha256(vim.uv.cwd() or ""))
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
      ["language/progressReport"] = jdtls_progress_report,
    },
  }
  local final_config = vim.tbl_deep_extend("force", default_opts, extra_jdtls_config)
  lsp_config.jdtls.setup(final_config)
end

return M
