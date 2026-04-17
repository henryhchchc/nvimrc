local M = {}

--- @param colors CtpColors<string>
function M.mocha_overrides(colors)
  return {
    NormalFloat = { bg = colors.surface0 },
    FloatBorder = { bg = colors.surface0 },
    FloatTitle = { bg = colors.blue, fg = colors.base, style = { "bold" } },
    Pmenu = { link = "NormalFloat" },
    LspCodeLens = { style = { "italic" } },
    TelescopeNormal = { link = "NormalFloat" },
    TelescopePromptTitle = { link = "FloatTitle" },
    TelescopeResultsTitle = { bg = colors.lavender, fg = colors.base, style = { "bold" } },
    TelescopePreviewTitle = { bg = colors.green, fg = colors.base, style = { "bold" } },
    ["@comment.error"] = { fg = colors.red, bg = colors.none, style = { "bold" } },
    ["@comment.warning"] = { fg = colors.yellow, bg = colors.none, style = { "bold" } },
    ["@comment.todo"] = { fg = colors.peach, bg = colors.none, style = { "bold" } },
    ["@comment.note"] = { fg = colors.blue, bg = colors.none, style = { "bold" } },
    ["@lsp.mod.mutable"] = { style = { "underline" } },
    TreesitterContextBottom = { sp = colors.lavender, style = { "underline" } },
    TreesitterContextLineNumber = { fg = colors.surface1, bg = colors.mantle },
  }
end

return M
