local M = {}

function M.setup(bufnr)
  vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "LSP Rename", buf = bufnr })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buf = bufnr })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definitions", buf = bufnr })
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP Type Definitions", buf = bufnr })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Implementations", buf = bufnr })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP References", buf = bufnr })
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP Signagure Help", buf = bufnr })
  vim.keymap.set("n", "<leader>lL", vim.lsp.codelens.run, { desc = "LSP Run Codelens", buf = bufnr })
end

return M
