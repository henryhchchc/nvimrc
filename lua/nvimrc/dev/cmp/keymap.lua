local tab_mapping = function(fallback)
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif cmp.visible() and cmp.get_active_entry() then
    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
  else
    fallback()
  end
end

local tap_mapping_cmdline = function(_fallback)
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.select_next_item()
  end
end

local shift_tab_mapping = function(fallback)
  local luasnip = require("luasnip")
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

local return_mapping = function(fallback)
  local cmp = require("cmp")
  if cmp.visible() and cmp.get_selected_entry() ~= nil then
    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
  else
    fallback()
  end
end

local M = {}

local cmp = require("cmp")

--- @type table<string, cmp.MappingClass>
M.insert = {
  ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
  ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
  ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  ["<C-e>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
  ["<TAB>"] = cmp.mapping(tab_mapping, { "i", "c", "s" }),
  ["<S-TAB>"] = cmp.mapping(shift_tab_mapping, { "i", "c", "s" }),
  ["<CR>"] = cmp.mapping(return_mapping, { "i" }),
}

M.cmdline = {
  ["<TAB>"] = cmp.mapping(tap_mapping_cmdline, { "i", "c", "s" }),
}

return M
