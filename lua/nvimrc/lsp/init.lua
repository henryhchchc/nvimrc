local M = {}

local function on_attach(client, bufnr)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = bufnr })
  vim.keymap.set(
    "n",
    "gd",
    function() vim.cmd.Lspsaga("goto_definition") end,
    { desc = "LSP Definitions", buffer = bufnr }
  )
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "LSP Implementations", buffer = bufnr })
  vim.keymap.set("n", "gr", function() vim.cmd.Lspsaga("finder") end, { desc = "LSP References", buffer = bufnr })
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP Signagure Help", buffer = bufnr })
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP Signagure Help", buffer = bufnr })
  vim.keymap.set("n", "<leader>gl", vim.lsp.codelens.run, { desc = "LSP Run Codelens", buffer = bufnr })
  vim.keymap.set("n", "K", function() vim.cmd.Lspsaga("hover_doc") end, { desc = "LSP Hover Doc", buffer = bufnr })

  if client.server_capabilities.codeLensProvider ~= nil then
    local codelen_group = vim.api.nvim_create_augroup("lsp_codelens", {})
    vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "InsertLeave" }, {
      buffer = bufnr,
      group = codelen_group,
      callback = function(event) vim.lsp.codelens.refresh() end,
    })
  end
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
