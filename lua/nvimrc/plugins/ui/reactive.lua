--- @type LazyPluginSpec
return {
  "rasulomaroff/reactive.nvim",
  event = "VimEnter",
  --- @type Reactive.Config
  opts = {
    load = { "catppuccin-mocha-cursor", "catppuccin-mocha-cursorline" },
  },
}
