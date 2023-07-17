local tabMapping = function(fallback)
    local luasnip = require("luasnip")
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        fallback()
    end
end
local sTabMapping = function(fallback)
    local luasnip = require("luasnip")
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end
local crMapping = function(fallback)
    local cmp = require("cmp")
    local entry = cmp.get_selected_entry()
    if entry then
        cmp.confirm()
    else
        fallback()
    end
end

local cmp = require("cmp")

--- @type table<string, cmp.MappingClass>
return {
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
    ["<TAB>"] = cmp.mapping(tabMapping, { "i", "c", "s" }),
    ["<S-TAB>"] = cmp.mapping(sTabMapping, { "i", "c", "s" }),
    ["<CR>"] = cmp.mapping(crMapping, { "i" }),
}
