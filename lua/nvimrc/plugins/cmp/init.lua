local function configure()
  local lspkind = require("lspkind")
  local lspKindOptions = require("nvimrc.plugins.cmp.lspkind").options
  local cmp = require("cmp")
  local keymap = require("nvimrc.plugins.cmp.keymap")

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
        local luasnip = require("luasnip")
        luasnip.lsp_expand(args.body)
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
      { name = "luasnip" },
      { name = "buffer", max_item_count = 5 },
    },
    matching = {
      disallow_partial_fuzzy_matching = false,
    },
    view = {
      entries = { name = "custom" },

    },
    window = {
      completion = cmp.config.window.bordered(),
    },
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
      { name = "path", group_index = 2 },
      { name = "cmdline", group_index = 2 },
      { name = "cmdline_history", group_index = 2, max_item_count = 5 },
      { name = "fuzzy_path", group_index = 1, option = { fd_timeout_msec = 1500 } },
    },
    preselect = cmp.PreselectMode.Item,
    mapping = keymap.cmdline,
    view = {
      entries = { name = "custom" },
    },
    enabled = function ()
      -- Set of commands where cmp will be disabled
      local disabled = {
        IncRename = true,
      }
      -- Get first word of cmdline
      local cmd = vim.fn.getcmdline():match("%S+")
      -- Return true if cmd isn't disabled
      -- else call/return cmp.close(), which returns false
      return not disabled[cmd] or cmp.close()
    end,
  })
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  cmp.event:on("menu_opened", function (_event)
    local bufnr = vim.api.nvim_get_current_buf()
    vim.b[bufnr].copilot_suggestion_hidden = true
  end)
  cmp.event:on("menu_closed", function (_event)
    local bufnr = vim.api.nvim_get_current_buf()
    vim.b[bufnr].copilot_suggestion_hidden = false
  end)
end

--- @type LazyPluginSpec[]
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "dmitmel/cmp-cmdline-history" },
      {
        "tzachar/cmp-fuzzy-path",
        dependencies = { { "tzachar/fuzzy.nvim" } },
      },
    },
    config = configure,
    event = { "InsertEnter", "CmdlineEnter" },
  },
  { "onsails/lspkind-nvim" },
  {
    "L3MON4D3/LuaSnip",
    opts = { delete_check_events = "TextChanged" },
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function (_, opts)
      require("luasnip").setup(opts)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
