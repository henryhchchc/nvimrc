local lsp = require("nvimrc.lsp")

local function configure()
  require("neoconf").setup({})
  require("neodev").setup({})
  require("nvimrc.plugins.lsp.jdtls")
  require("nvimrc.plugins.lsp.texlab")
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
    "clangd",
    "cssls",
    "html",
    "grammarly",
    "hls",
    "kotlin_language_server",
    "lua_ls",
    "pylsp",
    "taplo",
    "tsserver",
  }
  local conditional_add = {
    ["nil"] = "nil_ls",
    ["sourcekit-lsp"] = "sourcekit",
  }
  for exec, lsp_name in pairs(conditional_add) do
    if vim.fn.executable(exec) == 1 then table.insert(to_setup, lsp_name) end
  end

  for _, server in ipairs(to_setup) do
    lsp.setup_with_default(server, {})
  end
end

--- @type LazyPluginSpec[]
return {
  { "neovim/nvim-lspconfig", config = configure, event = "VeryLazy" },
  { "folke/neodev.nvim" },
  { "folke/neoconf.nvim", cmd = "Neoconf", dependencies = { "nvim-lspconfig" } },
  {
    "smjonas/inc-rename.nvim",
    config = function ()
      require("inc_rename").setup()
      vim.api.nvim_create_autocmd("CmdlineLeave", {
        callback = function () vim.fn.histdel("cmd", "^IncRename ") end,
      })
      local rename_func = function () return ":IncRename " .. vim.fn.expand("<cword>") end
      vim.keymap.set("n", "<leader>rn", rename_func, { expr = true, desc = "LSP Rename" })
    end,
    event = "LspAttach",
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    cmd = "Lspsaga",
    dependencies = { "catppuccin/nvim" },
    config = function ()
      local opts = {
        code_action = {
          keys = {
            quit = { "q", "<C-c>", "<esc>" },
          },
        },
        lightbulb = {
          sign = true,
          virtual_text = false,
        },
        ui = {
          code_action = "󰌶",
          kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        },
      }
      require("lspsaga").setup(opts)
    end,
  },
  { "b0o/schemastore.nvim" },
}
