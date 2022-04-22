local M = {}

-- stylua: ignore
local nordColors = {
    nord0  = "#2E3440", -- nord0 in palette
    nord1  = "#3B4252", -- nord1 in palette
    nord2  = "#434C5E", -- nord2 in palette
    nord3  = "#4C566A", -- nord3 in palette
    nord4  = "#D8DEE9", -- nord4 in palette
    nord5  = "#E5E9F0", -- nord5 in palette
    nord6  = "#ECEFF4", -- nord6 in palette
    nord7  = "#8FBCBB", -- nord7 in palette
    nord8  = "#88C0D0", -- nord8 in palette
    nord9  = "#81A1C1", -- nord9 in palette
    nord10 = "#5E81AC", -- nord10 in palette
    nord11 = "#BF616A", -- nord11 in palette
    nord12 = "#D08770", -- nord12 in palette
    nord13 = "#EBCB8B", -- nord13 in palette
    nord14 = "#A3BE8C", -- nord14 in palette
    nord15 = "#B48EAD", -- nord15 in palette
}

M.nordColors = nordColors

-- stylua: ignore
local colors = {
    bg        = "#1A1A1A",
    bg_alt    = "#212121",
    fg        = nordColors.nord4,
    text      = nordColors.nord4,
    selection = nordColors.nord2,
    contrast  = "#2F2F2F",
    active    = nordColors.nord1,
    border    = nordColors.nord3,
    highlight = nordColors.nord0,
    disabled  = nordColors.nord1,
    accent    = nordColors.nord7,

    white    = nordColors.nord6,
    gray     = nordColors.nord1,
    black    = "#000000",
    red      = nordColors.nord11,
    green    = nordColors.nord14,
    yellow   = nordColors.nord13,
    blue     = nordColors.nord9,
    paleblue = nordColors.nord10,
    cyan     = nordColors.nord8,
    purple   = nordColors.nord15,
    orange   = nordColors.nord12,
    pink     = nordColors.nord15,
}

-- stylua: ignore
M.colorPalette = vim.tbl_deep_extend("force", colors, {
    -- background
    bg_nc = colors.bg,
    bg_sign = colors.bg,
    bg_num = colors.bg,
    float = colors.bg_alt,
    sidebar = colors.bg,
    bg_vsp = colors.border,
    bg_cur = nordColors.nord0,

    line_numbers = nordColors.nord2,
})


return M
