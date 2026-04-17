local auto_format_group = vim.api.nvim_create_augroup("lsp_auto_format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = auto_format_group,
  callback = function ()
    if vim.b.autoformat then
      vim.lsp.buf.format({ async = false })
    end
  end,
})
