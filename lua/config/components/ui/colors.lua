local M = {}

-- stylua: ignore
local nordColors = {
    nord0  = "#2E3440", -- nord0
    nord1  = "#3B4252", -- nord1
    nord2  = "#434C5E", -- nord2
    nord3  = "#4C566A", -- nord3
    nord4  = "#D8DEE9", -- nord4
    nord5  = "#E5E9F0", -- nord5
    nord6  = "#ECEFF4", -- nord6
    nord7  = "#8FBCBB", -- nord7
    nord8  = "#88C0D0", -- nord8
    nord9  = "#81A1C1", -- nord9
    nord10 = "#5E81AC", -- nord10
    nord11 = "#BF616A", -- nord11
    nord12 = "#D08770", -- nord12
    nord13 = "#EBCB8B", -- nord13
    nord14 = "#A3BE8C", -- nord14
    nord15 = "#B48EAD", -- nord15
}

M.nordColors = nordColors

-- stylua: ignore
local colors = {
    bg        = "#1E1E1E",
    bg_alt    = "#252525",
    fg        = nordColors.nord4,
    text      = nordColors.nord4,
    selection = nordColors.nord1,
    contrast  = "#2F2F2F",
    active    = nordColors.nord1,
    border    = nordColors.nord3,
    highlight = nordColors.nord3,
    disabled  = nordColors.nord1,
    accent    = nordColors.nord7,

    white    = nordColors.nord6,
    gray     = "#808080",
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
    bg_nc        = colors.bg,
    bg_sign      = colors.bg,
    bg_num       = colors.bg,
    sidebar      = colors.bg,
    float        = colors.bg_alt,
    bg_vsp       = colors.border,
    bg_cur       = nordColors.nord0,
    line_numbers = nordColors.nord2,
})

return M
