local keymaps = require("nvimrc.lsp.keymaps")
local utils = require("nvimrc.utils")

local M = {}

local function setup_autoformat(client, bufnr)
  if not client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
    return
  end

  vim.b[bufnr].autoformat = true
  vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})"

  vim.keymap.set("n", "<leader>uf", function ()
    utils.toggle_buf_var("autoformat")
  end, { desc = "Toggle autoformat", buffer = bufnr })
end

local function setup_folding(client)
  if not client:supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange) then
    return
  end

  local win = vim.api.nvim_get_current_win()
  vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
end

local function setup_document_highlight(client, bufnr)
  if not client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    return
  end

  local group = vim.api.nvim_create_augroup(("lsp_document_highlight_%d"):format(bufnr), { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = bufnr,
    group = group,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = bufnr,
    group = group,
    callback = vim.lsp.buf.clear_references,
  })
  vim.api.nvim_create_autocmd("LspDetach", {
    buffer = bufnr,
    group = group,
    callback = function ()
      vim.lsp.buf.clear_references()
      vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
    end,
  })
end

--- @param client vim.lsp.Client
--- @param bufnr number
function M.on_attach(client, bufnr)
  keymaps.setup(bufnr)

  vim.lsp.codelens.enable(true)
  vim.lsp.inlay_hint.enable(true)
  vim.lsp.semantic_tokens.enable(true)

  setup_autoformat(client, bufnr)
  setup_folding(client)
  setup_document_highlight(client, bufnr)
end

return M
