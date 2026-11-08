---@class nvimrc.Folding
local M = {}

---@param bufnr integer
function M.refresh(bufnr)
  if not vim.api.nvim_buf_is_loaded(bufnr) then return end
  local expression = "0"
  if #vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/foldingRange" }) > 0 then
    expression = "v:lua.vim.lsp.foldexpr()"
  else
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if ok and parser then expression = "v:lua.vim.treesitter.foldexpr()" end
  end
  for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
    vim.wo[win][0].foldexpr = expression
  end
end

return M
