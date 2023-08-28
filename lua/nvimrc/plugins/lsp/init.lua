local lsp = require("nvimrc.lsp")

local function configure()
  require("neoconf").setup({})
  require("neodev").setup({})
  require("nvimrc.plugins.lsp.jdtls")
  require("nvimrc.plugins.lsp.texlab")
  require("nvimrc.plugins.lsp.efm")
  lsp.setup_with_default("jsonls", {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  })
  lsp.setup_with_default("yamlls", {
    yaml = {
      schemaStore = {
        enable = true,
      },
    },
  })
  local to_setup = {
    "bashls",
    "cssls",
    "html",
    "grammarly",
    "hls",
    "kotlin_language_server",
    "lua_ls",
    "nil_ls",
    "sourcekit",
    "pylsp",
    "taplo",
  }
  for _, server in ipairs(to_setup) do
    lsp.setup_with_default(server, {})
  end
end

--- @type LazyPluginSpec[]
return {
  { "neovim/nvim-lspconfig", config = configure, event = "VeryLazy" },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      sign = { enabled = false },
      autocmd = { enabled = true },
      virtual_text = { enabled = true, text = "󰌶", hl_mode = "combine" },
    },
  },
  { "folke/neodev.nvim" },
  { "folke/neoconf.nvim", cmd = "Neoconf", dependencies = { "nvim-lspconfig" } },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
      local rename_func = function() return ":IncRename " .. vim.fn.expand("<cword>") end
      vim.keymap.set("n", "<leader>rn", rename_func, { expr = true, desc = "LSP Rename" })
    end,
    event = "LspAttach",
  },
  { "b0o/schemastore.nvim" },
  {
    "stevearc/aerial.nvim",
    opts = {
      backends = { "lsp", "treesitter", "markdown", "man" },
      min_width = 20,
    },
    cmd = { "AerialToggle", "AerialOpen", "AerialOpenAll" },
  },
}
