-- Buffer-local mappings applied when a language server attaches.
local M = {}

function M.setup(bufnr)
  vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "LSP Rename", buf = bufnr })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definitions", buf = bufnr })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buf = bufnr })
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "LSP Type Definitions", buf = bufnr })
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "LSP Implementations", buf = bufnr })
  vim.keymap.set("n", "gA", vim.lsp.buf.references, { desc = "LSP References", buf = bufnr })
  vim.keymap.set("n", "<leader>lL", vim.lsp.codelens.run, { desc = "LSP Run Codelens", buf = bufnr })
end

return M
