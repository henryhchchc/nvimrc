-- Buffer-local mappings applied when a language server attaches.

local function setup_keymaps(bufnr)
  vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "LSP Rename", buf = bufnr })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definitions", buf = bufnr })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration", buf = bufnr })
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "LSP Type Definitions", buf = bufnr })
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "LSP Implementations", buf = bufnr })
  vim.keymap.set("n", "gA", vim.lsp.buf.references, { desc = "LSP References", buf = bufnr })
  vim.keymap.set("n", "<leader>lL", vim.lsp.codelens.run, { desc = "LSP Run Codelens", buf = bufnr })
end

local utils = require("nvimrc.utils")


local function setup_autoformat(client, bufnr)
  if not client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
    return
  end

  if vim.b[bufnr].autoformat == nil then
    vim.b[bufnr].autoformat = true
  end
  vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})"

  vim.keymap.set("n", "<leader>uf", function ()
    utils.toggle_buf_var("autoformat")
  end, { desc = "Toggle autoformat", buf = bufnr })
end

local function setup_folding(bufnr)
  local clients = vim.lsp.get_clients({
    bufnr = bufnr,
    method = vim.lsp.protocol.Methods.textDocument_foldingRange,
  })
  for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
    if #clients > 0 then
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    elseif vim.wo[win][0].foldexpr == "v:lua.vim.lsp.foldexpr()" then
      vim.wo[win][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end
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
local function setup_attach()
  local group = vim.api.nvim_create_augroup("nvimrc_lsp_attach", { clear = true })
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    callback = function (event)
      setup_folding(event.buf)
    end,
  })
  vim.api.nvim_create_autocmd("LspDetach", {
    group = group,
    callback = function (event)
      vim.schedule(function ()
        if vim.api.nvim_buf_is_valid(event.buf) then
          setup_folding(event.buf)
        end
      end)
    end,
  })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function (event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then
        return
      end

      setup_keymaps(event.buf)

      if not vim.b[event.buf].lsp_features_initialized then
        local filter = { bufnr = event.buf }
        vim.lsp.codelens.enable(true, filter)
        vim.lsp.inlay_hint.enable(true, filter)
        vim.lsp.semantic_tokens.enable(true, filter)
        vim.b[event.buf].lsp_features_initialized = true
      end

      setup_autoformat(client, event.buf)
      setup_folding(event.buf)
      setup_document_highlight(client, event.buf)
    end,
  })
end

local M = {}

function M.setup()
  require("nvimrc.config.diagnostic")

  setup_attach()

  vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  })

  vim.lsp.enable({
    "bashls",
    "clangd",
    "cssls",
    "dockerls",
    "fish_lsp",
    "html",
    "jdtls",
    "jsonls",
    "lua_ls",
    "neocmake",
    "ruff",
    "rumdl",
    "rust_analyzer",
    "sourcekit",
    "texlab",
    "tinymist",
    "tombi",
    "ts_ls",
    "ty",
    "typos_lsp",
    "yamlls",
  })
end

return M
