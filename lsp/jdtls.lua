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

local jdtls_cache_dir = vim.fs.joinpath(vim.uv.os_homedir(), ".cache", "jdtls")
local config_dir = vim.fs.joinpath(jdtls_cache_dir, "config")

---@type vim.lsp.Config
return {
  cmd = function (dispatchers, config)
    local root_dir = assert(config.root_dir, "JDTLS requires a project root")
    local data_dir = vim.fs.joinpath(jdtls_cache_dir, "project_data", vim.fn.sha256(root_dir))
    return vim.lsp.rpc.start({
      "jdtls",
      "-configuration",
      config_dir,
      "-data",
      data_dir,
      "--jvm-arg=-XX:+UseZGC",
    }, dispatchers, {
      cwd = config.cmd_cwd,
      env = config.cmd_env,
      detached = config.detached,
    })
  end,
  workspace_required = true,
  init_options = {
    workspace = config_dir,
    jvm_args = { "-XX:+UseZGC" },
    extendedClientCapabilities = {
      progressReportProvider = true,
    },
  },
  handlers = {
    ["language/progressReport"] = jdtls_progress_report,
  },
  filetypes = { "java" },
}
