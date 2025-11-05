local terminal = {
  background = "#151515",
  alt_background = "#1F1F1F",
  float_background = "#2C2C2C",
}

--- @type CtpIntegrations
local catppuccin_integrations = {
  bufferline = true,
  blink_cmp = true,
  fidget = true,
  gitsigns = true,
  indent_blankline = {
    enabled = true,
    colored_indent_levels = true,
  },
  markdown = true,
  native_lsp = {
    enabled = true,
    virtual_text = {
      errors = { "italic" },
      hints = { "italic" },
      warnings = { "italic" },
      information = { "italic" },
      ok = { "italic" },
    },
    underlines = {
      errors = { "underline" },
      hints = { "underline" },
      warnings = { "underline" },
      information = { "underline" },
      ok = { "underline" },
    },
    inlay_hints = {
      background = true,
    },
  },
  nvim_surround = true,
  neogit = true,
  neotree = true,
  rainbow_delimiters = true,
  semantic_tokens = true,
  telescope = { enabled = true },
  treesitter = true,
  treesitter_context = true,
}

--- @param colors CtpColors<string>
local function mocha_overrides(colors)
  return {
    NormalFloat = { bg = colors.surface0 },
    FloatBorder = { bg = colors.surface0 },
    FloatTitle = { bg = colors.blue, fg = colors.base, style = { "bold" } },
    Pmenu = { link = "NormalFloat" },
    -- NotifyBackground = { bg = "#000000" },
    LspCodeLens = { style = { "italic", "underline" } },
    -- Telescope
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

--- @type CatppuccinOptions
local catppuccin_opts = {
  transparent_background = true,
  term_colors = false,
  show_end_of_buffer = true,
  highlight_overrides = {
    mocha = mocha_overrides,
  },
  color_overrides = {
    mocha = {
      base = terminal.background,
    },
  },
  default_integrations = false,
  integrations = catppuccin_integrations,
}

--- @type LazyPluginSpec
return {
  "catppuccin/nvim",
  main = "catppuccin",
  name = "catppuccin",
  priority = 1000,
  opts = catppuccin_opts,
  config = function (_plugin, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
