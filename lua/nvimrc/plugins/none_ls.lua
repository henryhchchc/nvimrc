--- @type LazyPluginSpec
return {
  "nvimtools/none-ls.nvim",
  main = "null-ls",
  opts = function (self, opts)
    local builtins = require("null-ls.builtins")
    opts.sources = {
      builtins.formatting.prettierd,
    }
  end,
  event = "VeryLazy",
}
