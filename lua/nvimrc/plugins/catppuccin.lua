--- @param colors CtpColors<string>
local function mocha_overrides(colors)
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

local dark_terminal = {
  background = "#151515",
  alt_background = "#1F1F1F",
  float_background = "#2C2C2C",
}



--- @type CatppuccinOptions
local options = {
  flavour = "auto",
  background = {
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true,
  term_colors = false,
  highlight_overrides = {
    mocha = mocha_overrides,
  },
  color_overrides = {
    mocha = {
      base = dark_terminal.background,
    },
  },
  auto_integrations = false,
  integrations = {
    blink_cmp = true,
    fidget = true,
    gitsigns = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    nvim_surround = true,
    neogit = true,
    neotree = true,
    blink_pairs = true,
    telescope = true,
    treesitter_context = true,
  },
}

require("catppuccin").setup(options)
vim.cmd.colorscheme("catppuccin")
