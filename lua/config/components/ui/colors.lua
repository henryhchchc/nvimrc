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
M.nordFox = {
    bg0  = "#252525",
    bg1  = "#1E1E1E",
    bg3  = nordColors.nord0,
    sel0 = "#323232",
}

return M
