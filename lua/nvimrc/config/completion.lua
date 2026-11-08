local function popup_key(key, fallback)
  return function ()
    return vim.fn.pumvisible() == 1 and key or fallback
  end
end

local kind_styles = {
  { "󰉿", "@string" }, -- Text
  { "󰊕", "@function.method" }, -- Method
  { "󰊕", "@function" }, -- Function
  { "󰒓", "@constructor" }, -- Constructor
  { "󰜢", "@variable.member" }, -- Field
  { "󰆦", "@variable" }, -- Variable
  { "󰠱", "@type" }, -- Class
  { "", "@type" }, -- Interface
  { "󰅩", "@module" }, -- Module
  { "󰖷", "@property" }, -- Property
  { "󰪚", "@number" }, -- Unit
  { "󰦨", "@constant" }, -- Value
  { "", "@type" }, -- Enum
  { "󰻾", "@keyword" }, -- Keyword
  { "󱄽", "@markup" }, -- Snippet
  { "󰏘", "@string" }, -- Color
  { "󰈔", "@string.special.path" }, -- File
  { "󰬲", "@markup.link" }, -- Reference
  { "󰉋", "@module" }, -- Folder
  { "", "@constant" }, -- EnumMember
  { "󰏿", "@constant" }, -- Constant
  { "󰙅", "@type" }, -- Struct
  { "󱐋", "@type" }, -- Event
  { "󰪚", "@operator" }, -- Operator
  { "󰬛", "@type" }, -- TypeParameter
}

local completion_group = vim.api.nvim_create_augroup("nvimrc_completion", { clear = true })
local function configure_completion(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  local enabled = vim.bo[bufnr].buftype == ""
      and #vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/completion" }) > 0
  vim.bo[bufnr].autocomplete = enabled
  vim.bo[bufnr].complete = enabled and "o" or vim.go.complete
end

vim.api.nvim_create_autocmd({ "FileType", "InsertEnter", "LspAttach", "LspDetach" }, {
  group = completion_group,
  callback = function (event)
    if event.event == "LspDetach" then
      vim.schedule(function () configure_completion(event.buf) end)
    else
      configure_completion(event.buf)
    end
  end,
})

vim.keymap.set("i", "<C-space>", function ()
  if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/completion" }) > 0 then
    vim.lsp.completion.get()
  else
    vim.api.nvim_feedkeys(vim.keycode("<C-n>"), "n", false)
  end
end, { desc = "Show completion" })

vim.keymap.set("i", "<CR>", function ()
  if vim.fn.pumvisible() == 0 then
    return "<CR>"
  end
  return vim.fn.complete_info({ "selected" }).selected == -1 and "<C-n><C-y>" or "<C-y>"
end, { expr = true, desc = "Accept completion" })
vim.keymap.set("i", "<C-c>", popup_key("<C-e>", "<C-c>"), { expr = true, desc = "Dismiss completion" })
vim.keymap.set("i", "<C-j>", popup_key("<C-n>", "<Down>"), { expr = true })
vim.keymap.set("i", "<C-k>", popup_key("<C-p>", "<Up>"), { expr = true })

local function snippet_key(direction, completion_key, fallback)
  return function ()
    if vim.snippet.active({ direction = direction }) then
      vim.schedule(function () vim.snippet.jump(direction) end)
      return ""
    end
    return vim.fn.pumvisible() == 1 and completion_key or fallback
  end
end

vim.keymap.set({ "i", "s" }, "<Tab>", snippet_key(1, "<C-n>", "<Tab>"), { expr = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", snippet_key(-1, "<C-p>", "<S-Tab>"), { expr = true })

vim.api.nvim_create_autocmd("CmdlineChanged", {
  group = completion_group,
  pattern = { ":", "/", "?" },
  callback = function () vim.fn.wildtrigger() end,
})

for key, action in pairs({ ["<C-j>"] = "<C-n>", ["<C-k>"] = "<C-p>" }) do
  local fallback = key == "<C-j>" and "<Down>" or "<Up>"
  vim.keymap.set("c", key, function ()
    return vim.fn.wildmenumode() == 1 and action or fallback
  end, { expr = true })
end

return {
  ---@param item lsp.CompletionItem
  convert = function (item)
    local style = kind_styles[item.kind] or {}
    local deprecated = item.deprecated
        or vim.list_contains(item.tags or {}, vim.lsp.protocol.CompletionTag.Deprecated)
    return {
      kind = style[1] or "",
      kind_hlgroup = style[2] or "",
      abbr_hlgroup = deprecated and "DiagnosticDeprecated" or style[2] or "",
      menu = "",
    }
  end,
}
