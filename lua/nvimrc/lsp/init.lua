local M = {}


local utils = require("nvimrc.utils")

function M.on_attach(client, bufnr)
  vim.keymap.set(
    "n",
    "gD",
    function () vim.lsp.buf.declaration({ loclist = true }) end,
    { desc = "LSP Declaration", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "gd",
    function () vim.lsp.buf.definition({ loclist = true }) end,
    { desc = "LSP Definitions", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "gI",
    function () vim.cmd.Trouble("lsp_implementations") end,
    { desc = "LSP Implementations", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "gr",
    function ()
      vim.cmd.Trouble("lsp_references")
    end,
    { desc = "LSP References", buffer = bufnr }
  )
  vim.keymap.set("n", "gf", function () vim.cmd.Lspsaga("finder") end, { desc = "LSP Finder", buffer = bufnr })
  -- vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP Signagure Help", buffer = bufnr })
  -- vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP Signagure Help", buffer = bufnr })
  vim.keymap.set(
    "n",
    "<leader>gl",
    vim.lsp.codelens.run,
    { desc = "LSP Run Codelens", buffer = bufnr }
  )

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
  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
  )
  --- @type table<string, function>
  local handlers = {
    [vim.lsp.protocol.Methods.textDocument_hover] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "rounded" }
    ),
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

function M.setup_with_default(server, settings, initialization_options)
  local lspConfig = require("lspconfig")
  local options = M.lsp_default_opts()
  options.init_options = initialization_options or {}
  options.settings = settings or {}
  lspConfig[server].setup(options)
end

return M
