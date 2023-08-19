local M = {}

local highlight_options = {
  headline_highlights = {
    "Headline1",
    "Headline2",
    "Headline3",
    "Headline4",
    "Headline5",
    "Headline6",
  },
  dash_string = "─",
  fat_headlines = true,
  fat_headline_upper_string = " ",
  fat_headline_lower_string = " ",
  codeblock_highlight = nil,
}

local options = {
  markdown = highlight_options,
  rmd = highlight_options,
  norg = highlight_options,
  org = highlight_options,
}

--- @type LazyPluginSpec
M.pluginSpec = {
  "lukas-reineke/headlines.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = options,
  ft = "markdown",
}

return M
