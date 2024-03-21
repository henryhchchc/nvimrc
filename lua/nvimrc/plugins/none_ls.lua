--- @type LazyPluginSpec
return {
  "nvimtools/none-ls.nvim",
  main = "null-ls",
  opts = function (_self, opts)
    local builtins = require("null-ls.builtins")
    opts.sources = {
      builtins.formatting.prettierd,
      builtins.diagnostics.actionlint,
    }
  end,
  event = "VeryLazy",
}
