--- @type LazyPluginSpec
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  config = true,
  opts = {
    options = {
      show_source = true,
    },
  },
}
