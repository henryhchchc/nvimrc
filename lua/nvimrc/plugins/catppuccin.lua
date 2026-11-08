--- @param colors CtpColors<string>
---@return table<string, CtpHighlight>
local function mocha_overrides(colors)
  return {
    NormalFloat = { bg = colors.surface0 },
    FloatBorder = { bg = colors.surface0 },
    FloatTitle = { bg = colors.blue, fg = colors.base, style = { "bold" } },
    Pmenu = { link = "NormalFloat" },
    PmenuBorder = { link = "FloatBorder" },
    PmenuSel = { fg = colors.text, bg = colors.surface1, style = { "bold" } },
    PmenuKind = { fg = colors.subtext0, bg = colors.surface0 },
    PmenuKindSel = { fg = colors.text, bg = colors.surface1, style = { "bold" } },
    PmenuExtraSel = { fg = colors.subtext0, bg = colors.surface1, style = { "bold" } },
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
  }
end




--- @type CatppuccinOptions
local options = {
  transparent_background = true,
  highlight_overrides = {
    mocha = mocha_overrides,
  },
  color_overrides = {
    mocha = {
      base = "#151515",
    },
  },
  integrations = {
    indent_blankline = {
      colored_indent_levels = true,
    },
  },
}

require("catppuccin").setup(options)
vim.cmd.colorscheme("catppuccin")
