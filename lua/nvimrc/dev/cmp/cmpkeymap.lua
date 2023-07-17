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

---@diagnostic disable-next-line: unused-local
local crMapping = function(fallback)
    local cmp = require("cmp")
    --- @type cmp.ConfirmOption
    local opts = {
        select = false,
        behavior = cmp.ConfirmBehavior.Replace,
    }
    cmp.confirm(opts)
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
