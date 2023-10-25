local function configure()
  local SymbolKind = vim.lsp.protocol.SymbolKind

  require("symbol-usage").setup({
    kinds = {
      SymbolKind.Function,
      SymbolKind.Method,
      SymbolKind.Constructor,
      SymbolKind.Class,
      SymbolKind.Struct,
      SymbolKind.Field,
    },
    request_pending_text = false,
    vt_position = "above",
    definition = { enabled = true },
    implementation = { enabled = true }
  })
end

return {
  "Wansmer/symbol-usage.nvim",
  event = "LspAttach",
  config = configure,
  keys = {
    {
      "<leader>ul",
      function()
        require("symbol-usage").toggle()
      end,
      desc = "Toggle symbol usage codelens"
    }
  }
}
