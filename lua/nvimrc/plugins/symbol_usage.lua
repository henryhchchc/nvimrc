local function configure()
  local function hl(name) return vim.api.nvim_get_hl(0, { name = name }) end

  -- hl-groups can have any name
  vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = hl("CursorLine").bg, italic = true })
  vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = hl("CursorLine").bg, fg = hl("Comment").fg, italic = true })
  vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = hl("Function").fg, bg = hl("CursorLine").bg, italic = true })
  vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = hl("Type").fg, bg = hl("CursorLine").bg, italic = true })
  vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = hl("@keyword").fg, bg = hl("CursorLine").bg, italic = true })

  local function text_format(symbol)
    if not symbol then return end
    local result = {}

    local round_start = { "", "SymbolUsageRounding" }
    local round_end = { "", "SymbolUsageRounding" }

    if symbol.references and symbol.references > 0 then
      local usage = symbol.references <= 1 and "usage" or "usages"
      local num = symbol.references == 0 and "no" or symbol.references
      table.insert(result, round_start)
      table.insert(result, { "󰌹 ", "SymbolUsageRef" })
      table.insert(result, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
      table.insert(result, round_end)
    end

    if symbol.definition and symbol.definition > 0 then
      if #result > 0 then
        table.insert(result, { " ", "NonText" })
      end
      table.insert(result, round_start)
      table.insert(result, { "󰳽 ", "SymbolUsageDef" })
      table.insert(result, { symbol.definition .. " defs", "SymbolUsageContent" })
      table.insert(result, round_end)
    end

    if symbol.implementation and symbol.implementation > 0 then
      if #result > 0 then
        table.insert(result, { " ", "NonText" })
      end
      table.insert(result, round_start)
      table.insert(result, { "󰡱 ", "SymbolUsageImpl" })
      table.insert(result, { symbol.implementation .. " impls", "SymbolUsageContent" })
      table.insert(result, round_end)
    end

    return result
  end

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
    text_format = text_format,
    vt_position = "end_of_line",
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
