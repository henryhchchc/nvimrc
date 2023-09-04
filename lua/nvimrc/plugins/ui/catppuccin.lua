local terminal = {
  background = "#151515",
  alt_background = "#1F1F1F",
}

--- @type CatppuccinOptions
local catppuccinOptions = {
  transparent_background = true,
  highlight_overrides = {
    mocha = function(colors)
      return {
        NormalFloat = { bg = colors.base },
        NotifyBackground = { bg = "#000000" },
        -- Headlines
        markdownCodeBlock = { bg = colors.none },
        CodeBlock = { link = "markdownCodeBlock" },
        Headline1 = { bg = colors.none, style = { "bold", "underdouble" } },
        Headline2 = { bg = colors.none, style = { "bold" } },
        Headline3 = { bg = colors.none, style = { "italic" } },
        Headline4 = { bg = colors.none },
        Headline5 = { bg = colors.none },
        Headline6 = { bg = colors.none },
        -- Telescope
        TelescopePromptTitle = { bg = colors.blue, fg = colors.base, style = { "bold" } },
        TelescopeResultsTitle = { bg = colors.lavender, fg = colors.base, style = { "bold" } },
        TelescopePreviewTitle = { bg = colors.green, fg = colors.base, style = { "bold" } },
      }
    end,
  },
  color_overrides = {
    mocha = {
      base = terminal.background,
    },
  },
  integrations = {
    aerial = true,
    bufferline = true,
    cmp = true,
    illuminate = true,
    indent_blankline = { enabled = true },
    lsp_trouble = true,
    lsp_saga = true,
    harpoon = true,
    headlines = true,
    hop = true,
    native_lsp = { enabled = true },
    navic = { enabled = true, custom_bg = "NONE" },
    neogit = true,
    neotree = true,
    noice = true,
    notify = true,
    nvimtree = false,
    semantic_tokens = true,
    telescope = true,
    treesitter = true,
    ts_rainbow2 = true,
    which_key = true,
  },
}

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup(catppuccinOptions)
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
