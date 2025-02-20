local M = {}


local utils = require("nvimrc.utils")

function M.on_attach(client, bufnr)
  vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "LSP Rename", buffer = bufnr })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = bufnr })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definitions", buffer = bufnr })
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "LSP Implementations", buffer = bufnr })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP References", buffer = bufnr })
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP Signagure Help", buffer = bufnr })
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP Signagure Help", buffer = bufnr })
  vim.keymap.set("n", "<leader>gl", vim.lsp.codelens.run, { desc = "LSP Run Codelens", buffer = bufnr })

  if client.server_capabilities.codeLensProvider ~= nil then
    local group_name = string.format("lsp_codelens_%d", bufnr)
    local codelen_group = vim.api.nvim_create_augroup(group_name, {})
    vim.lsp.codelens.refresh({ bufnr = bufnr })
    vim.api.nvim_create_autocmd(
      { "BufEnter", "TextChanged", "InsertLeave", "LspTokenUpdate" },
      {
        buffer = bufnr,
        group = codelen_group,
        callback = function (_event) vim.lsp.codelens.refresh({ bufnr = bufnr }) end,
      }
    )
  end

  if client.server_capabilities.documentFormattingProvider then
    vim.b["autoformat"] = true
    vim.keymap.set("n", "<leader>uf", function () utils.toggle_buf_var("autoformat") end,
      { desc = "Toggle autoformat", buffer = bufnr })
  end


  vim.lsp.inlay_hint.enable(true, {})
  vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})"
end

--- @return vim.lsp.ClientConfig
function M.lsp_default_opts()
  vim.cmd.packadd("blink.cmp")
  local capabilities = require("blink.cmp").get_lsp_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )
  --- @type table<string, function>
  local handlers = {
    -- [vim.lsp.protocol.Methods.textDocument_hover] = vim.lsp.with(
    --   vim.lsp.handlers.hover,
    --   { border = "rounded" }
    -- ),
    -- [vim.lsp.protocol.Methods.textDocument_signatureHelp] = vim.lsp.with(
    --   vim.lsp.handlers.signature_help,
    --   { border = "rounded" }
    -- ),
  }
  local lspFlags = {}
  --- @type vim.lsp.ClientConfig
  local client_config = {
    on_attach = M.on_attach,
    capabilities = capabilities,
    flags = lspFlags,
    handlers = handlers,
  }
  return client_config
end

--- Checks if the LSP server is installed for a LSP config
---@param lsp_config any The LSP config
---@return boolean|nil # `true` if the server is installed, `false` if not, `nil` if the cmd is not an executable
local function is_lsp_server_installed(lsp_config)
  assert(lsp_config, "lsp_config is required")
  if lsp_config.config_def
      and lsp_config.config_def.default_config
      and lsp_config.config_def.default_config.cmd then
    local cmd = lsp_config.config_def.default_config.cmd
    if type(cmd) == "table" then
      local exec = cmd[1]
      return vim.fn.executable(exec) == 1
    end
  end
  return nil
end

function M.setup(server, settings, initialization_options)
  local lsp_config = require("lspconfig")[server]
  if not lsp_config then
    vim.notify(string.format("Configuration for LSP server %s not found", server), vim.log.levels.ERROR)
    return
  elseif is_lsp_server_installed(lsp_config) == false then
    return
  end
  local options = M.lsp_default_opts()
  options.init_options = initialization_options or {}
  options.settings = settings or {}
  lsp_config.setup(options)
end

return M
