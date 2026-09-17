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
  end, { desc = "Toggle autoformat", buf = bufnr })
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
    buf = bufnr,
    group = group,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
    buf = bufnr,
    group = group,
    callback = vim.lsp.buf.clear_references,
  })
  vim.api.nvim_create_autocmd("LspDetach", {
    buf = bufnr,
    group = group,
    callback = function ()
      vim.lsp.buf.clear_references()
      vim.api.nvim_clear_autocmds({ group = group, buf = bufnr })
    end,
  })
end

--- Attach behaviour is wired through LspAttach rather than
--- vim.lsp.config("*").on_attach, because a server config's on_attach replaces
--- the "*" one instead of composing with it: nvim-lspconfig's configs for
--- clangd, rust_analyzer, texlab, tinymist and ts_ls define their own (to
--- create buffer-local commands), which silently disabled everything below,
--- including autoformat on save.
function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("nvimrc_lsp_attach", { clear = true }),
    callback = function (event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then
        return
      end

      keymaps.setup(event.buf)

      vim.lsp.codelens.enable(true)
      vim.lsp.inlay_hint.enable(true)
      vim.lsp.semantic_tokens.enable(true)

      setup_autoformat(client, event.buf)
      setup_folding(client)
      setup_document_highlight(client, event.buf)
    end,
  })
end

return M
