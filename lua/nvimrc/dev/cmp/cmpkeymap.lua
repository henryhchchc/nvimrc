local has_words_before = function()
    local loc = vim.api.nvim_win_get_cursor(0)
    local line, col = loc[1], loc[2]
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local tabMapping = function(fallback)
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    elseif has_words_before() then
        cmp.complete()
    else
        fallback()
    end
end
local sTabMapping = function(fallback)
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    if cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
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
