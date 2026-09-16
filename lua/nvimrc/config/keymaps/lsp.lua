vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Send diagnostics to quickfix list" })

vim.keymap.set({ "n", "v" }, "g.", function () vim.lsp.buf.code_action() end, { desc = "LSP Code Actions" })
vim.keymap.set({ "n", "v" }, "<leader>lf", function () vim.lsp.buf.format({ async = true }) end, { desc = "LSP Format" })

local function on_jump(_, bufnr)
  vim.diagnostic.open_float({ bufnr = bufnr })
end

vim.keymap.set("n", "]d", function ()
  vim.diagnostic.jump({ count = 1, on_jump = on_jump })
end, { desc = "Jump to next diagnostic" })
vim.keymap.set("n", "[d", function ()
  vim.diagnostic.jump({ count = -1, on_jump = on_jump })
end, { desc = "Jump to previous diagnostic" })
