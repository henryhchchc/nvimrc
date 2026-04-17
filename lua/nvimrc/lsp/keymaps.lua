local M = {}

function M.setup(bufnr)
  vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "LSP Rename", buffer = bufnr })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = bufnr })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definitions", buffer = bufnr })
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP Type Definitions", buffer = bufnr })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Implementations", buffer = bufnr })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP References", buffer = bufnr })
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP Signagure Help", buffer = bufnr })
  vim.keymap.set("n", "<leader>lL", vim.lsp.codelens.run, { desc = "LSP Run Codelens", buffer = bufnr })
end

return M
