local lspkind = require("lspkind")
local lspKindOptions = require("nvimrc.plugins.nvim-cmp.lspkind").options
local cmp = require("cmp")
local keymap = require("nvimrc.plugins.nvim-cmp.keymap")

vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format(lspKindOptions),
  },
  snippet = {
    expand = function (args)
      vim.snippet.expand(args.body)
    end,
  },
  experimental = {
    ghost_text = { hl_group = "CmpGhostText" },
  },
  preselect = cmp.PreselectMode.None,
  mapping = keymap.insert,
  sources = {
    { name = "nvim_lsp" },
    { name = "crates" },
    { name = "buffer", max_item_count = 5 },
  },
  view = {
    entries = { name = "custom" },
  },
  -- window = {
  --   completion = cmp.config.window.bordered(),
  --   documentation = cmp.config.window.bordered(),
  -- },
})

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
  view = {
    entries = { name = "custom" },
  },
})

cmp.setup.cmdline(":", {
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
  preselect = cmp.PreselectMode.Item,
  mapping = keymap.cmdline,
  view = {
    entries = { name = "custom" },
  },
  enabled = function ()
    -- Set of commands where cmp will be disabled
    local disabled = {}
    -- Get first word of cmdline
    local cmd = vim.fn.getcmdline():match("%S+")
    -- Return true if cmd isn't disabled
    -- else call/return cmp.close(), which returns false
    return not disabled[cmd] or cmp.close()
  end,
})

cmp.event:on("menu_opened", function (_event)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.b[bufnr].copilot_suggestion_hidden = true
end)
cmp.event:on("menu_closed", function (_event)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.b[bufnr].copilot_suggestion_hidden = false
end)
