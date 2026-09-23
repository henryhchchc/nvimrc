local dark_terminal = {
  background = "#151515",
  alt_background = "#1F1F1F",
  float_background = "#2C2C2C",
}

local highlights = require("nvimrc.plugins.catppuccin.highlights")

--- @type CatppuccinOptions
return {
  flavour = "auto",
  background = {
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true,
  term_colors = false,
  highlight_overrides = {
    mocha = highlights.mocha_overrides,
  },
  color_overrides = {
    mocha = {
      base = dark_terminal.background,
    },
  },
  auto_integrations = false,
  integrations = require("nvimrc.plugins.catppuccin.integrations"),
}
