local M = {}

local nordColors = {
    nord0 = "#2E3440", -- nord0 in palette
    nord1 = "#3B4252", -- nord1 in palette
    nord2 = "#434C5E", -- nord2 in palette
    nord3 = "#4C566A", -- nord3 in palette
    nord4 = "#D8DEE9", -- nord4 in palette
    nord5 = "#E5E9F0", -- nord5 in palette
    nord6 = "#ECEFF4", -- nord6 in palette
    nord7 = "#8FBCBB", -- nord7 in palette
    nord8 = "#88C0D0", -- nord8 in palette
    nord9 = "#81A1C1", -- nord9 in palette
    nord10 = "#5E81AC", -- nord10 in palette
    nord11 = "#BF616A", -- nord11 in palette
    nord12 = "#D08770", -- nord12 in palette
    nord13 = "#EBCB8B", -- nord13 in palette
    nord14 = "#A3BE8C", -- nord14 in palette
    nord15 = "#B48EAD", -- nord15 in palette
}

M.nordColors = nordColors

local colorPalette = {
    bg = "#212121",
    bg_alt = "#1A1A1A",
    fg = "#B0BEC5",
    text = "#727272",
    selection = "#404040",
    contrast = "#1A1A1A",
    active = "#323232",
    border = "#343434",
    highlight = "#3F3F3F",
    disabled = nordColors.nord2,
    accent = nordColors.nord7,

    white = nordColors.nord6,
    gray = "#717CB4",
    black = "#000000",
    red = nordColors.nord11,
    green = nordColors.nord14,
    yellow = nordColors.nord13,
    blue = nordColors.nord9,
    paleblue = nordColors.nord10,
    cyan = nordColors.nord8,
    purple = nordColors.nord15,
    orange = nordColors.nord12,
    pink = "#FF9CAC",
}

M.colorPalette = colorPalette

return M
