--- @type LazyPluginSpec
return {
  "nvimtools/none-ls.nvim",
  main = "null-ls",
  opts = function(plugin)
    local builtins = require("null-ls.builtins")
    return {}
  end,
}
