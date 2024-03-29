local function load_luasnip()
  if not package.loaded.luasnip then
    require("luasnip")
  end
  return package.loaded.luasnip
end

local function tab_mapping(fallback)
  local cmp = package.loaded.cmp
  local luasnip = load_luasnip()
  local copilot_suggestion = require("copilot.suggestion")
  if copilot_suggestion.is_visible() then
    copilot_suggestion.accept()
  elseif luasnip.expandable() then
    luasnip.expand()
  elseif cmp.visible() and cmp.get_active_entry() then
    cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
  else
    fallback()
  end
end

local function tap_mapping_cmdline(_fallback)
  local cmp = package.loaded.cmp
  if cmp.visible() then cmp.select_next_item() end
end

local function snip_jump(fallback)
  local luasnip = load_luasnip()
  if luasnip.jumpable(1) then
    luasnip.jump(1)
  else
    fallback()
  end
end

local function shift_tab_mapping(fallback)
  local luasnip = load_luasnip()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

local function return_mapping(fallback)
  local cmp = package.loaded.cmp
  if cmp.visible() and cmp.get_selected_entry() ~= nil then
    cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
  else
    fallback()
  end
end

local function copilot_suggest()
  local cmp = package.loaded.cmp
  local copilot_suggestion = require("copilot.suggestion")
  cmp.close()
  copilot_suggestion.next()
end

local M = {}

local cmp = package.loaded.cmp


--- @type table<string, cmp.Mapping>
M.insert = {
  ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
  ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
  ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  ["<C-c>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
  ["<TAB>"] = cmp.mapping(tab_mapping, { "i", "c", "s" }),
  ["<TAB><TAB>"] = cmp.mapping(snip_jump, { "i", "c", "s" }),
  ["<S-TAB>"] = cmp.mapping(shift_tab_mapping, { "i", "c", "s" }),
  ["<CR>"] = cmp.mapping(return_mapping, { "i" }),
  ["<C-s>"] = cmp.mapping(copilot_suggest, { "i" }),
}

--- @type table<string, cmp.Mapping>
M.cmdline = {
  ["<TAB>"] = cmp.mapping(tap_mapping_cmdline, { "i", "c", "s" }),
}

return M
