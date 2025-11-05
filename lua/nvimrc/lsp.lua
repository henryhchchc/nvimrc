local M = {}
local utils = require("nvimrc.utils")

local function setup_keymaps(bufnr)
  vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "LSP Rename", buffer = bufnr })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buffer = bufnr })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definitions", buffer = bufnr })
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP Type Definitions", buffer = bufnr })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Implementations", buffer = bufnr })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP References", buffer = bufnr })
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP Signagure Help", buffer = bufnr })
  vim.keymap.set("n", "<leader>gl", vim.lsp.codelens.run, { desc = "LSP Run Codelens", buffer = bufnr })
end

--- @param client vim.lsp.Client
--- @param bufnr number
function M.lsp_on_attach(client, bufnr)
  setup_keymaps(bufnr)

  local lsp_methods = vim.lsp.protocol.Methods

  if client:supports_method(lsp_methods.textDocument_codeLens) then
    local group_name = string.format("lsp_codelens_%d", bufnr)
    local codelen_group = vim.api.nvim_create_augroup(group_name, {})
    vim.lsp.codelens.refresh({ bufnr = bufnr })
    vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "InsertLeave", "LspTokenUpdate" }, {
      buffer = bufnr,
      group = codelen_group,
      callback = function (_event) vim.lsp.codelens.refresh({ bufnr = bufnr }) end,
    })
  end

  if client:supports_method(lsp_methods.textDocument_formatting) then
    vim.b["autoformat"] = true
    vim.keymap.set(
      "n",
      "<leader>uf",
      function () utils.toggle_buf_var("autoformat") end,
      { desc = "Toggle autoformat", buffer = bufnr }
    )
    vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})"
  end

  if client:supports_method(lsp_methods.textDocument_foldingRange) then
    local win = vim.api.nvim_get_current_win()
    vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
  end

  vim.lsp.inlay_hint.enable(true, {})

  if client:supports_method(lsp_methods.textDocument_documentHighlight) then
    -- Show LSP document highlight on cursor hold
    local document_hl_group = vim.api.nvim_create_augroup("lsp_document_highlight", {})
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = document_hl_group,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = document_hl_group,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return M
