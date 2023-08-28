local M = {}

local function on_attach(client, bufnr)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = bufnr })
  vim.keymap.set(
    "n",
    "gd",
    function() vim.cmd.Trouble("lsp_definitions") end,
    { desc = "LSP Definitions", buffer = bufnr }
  )
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "LSP Implementations", buffer = bufnr })
  vim.keymap.set(
    "n",
    "gr",
    function() vim.cmd.Trouble("lsp_references") end,
    { desc = "LSP References", buffer = bufnr }
  )
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP Signagure Help", buffer = bufnr })
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP Signagure Help", buffer = bufnr })
  vim.keymap.set("n", "<leader>gl", vim.lsp.codelens.run, { desc = "LSP Run Codelens", buffer = bufnr })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover Doc", buffer = bufnr })
end

function M.lsp_default_opts()
  local initial_caps = vim.lsp.protocol.make_client_capabilities()
  local capabilities = require("cmp_nvim_lsp").default_capabilities(initial_caps)
  local lspFlags = {}
  return {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lspFlags,
  }
end

function M.setup_with_default(server, settings)
  local lspConfig = require("lspconfig")
  local options = M.lsp_default_opts()
  options.settings = settings or {}
  lspConfig[server].setup(options)
end

return M
