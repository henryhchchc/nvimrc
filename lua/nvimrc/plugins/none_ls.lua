--- @type LazyPluginSpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  main = "null-ls",
  opts = function (_self, opts)
    local builtins = require("null-ls.builtins")
    opts.sources = {
      builtins.formatting.prettierd,
      builtins.diagnostics.actionlint,
      builtins.formatting.ktlint,
      builtins.hover.dictionary,
      builtins.hover.printenv,
    }
    opts.on_attach = require("nvimrc.lsp").on_attach
  end,
  event = "VeryLazy",
}
