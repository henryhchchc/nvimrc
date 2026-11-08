-- Buffer-local mappings applied when a language server attaches.

---@param bufnr integer
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


---@param client vim.lsp.Client
---@param bufnr integer
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

local setup_folding = require("nvimrc.config.folding").refresh

---@param client vim.lsp.Client
---@param bufnr integer
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
      vim.schedule(function ()
        if not vim.api.nvim_buf_is_valid(bufnr) then return end
        local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/documentHighlight" })
        if #clients == 0 then
          vim.api.nvim_buf_call(bufnr, vim.lsp.buf.clear_references)
          vim.api.nvim_clear_autocmds({ group = group, buf = bufnr })
        end
      end)
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

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("nvimrc_autoformat", { clear = true }),
  callback = function (event)
    if require("nvimrc.config.lsp").can_format(event.buf) then
      vim.lsp.buf.format({ bufnr = event.buf })
    end
  end,
})

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
  "taplo",
  "ts_ls",
  "ty",
  "typos_lsp",
  "yamlls",
})

---@class nvimrc.Lsp
---@field can_format fun(bufnr: integer): boolean?
---@type nvimrc.Lsp
return {
  ---@param bufnr integer
  ---@return boolean?
  can_format = function (bufnr)
    return vim.b[bufnr].autoformat and #vim.lsp.get_clients({
      bufnr = bufnr, method = "textDocument/formatting",
    }) > 0
  end,
}
