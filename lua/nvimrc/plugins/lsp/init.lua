local lsp = require("nvimrc.lsp")

local function configure()
  require("neoconf").setup({})
  require("neodev").setup({})
  require("nvimrc.plugins.lsp.jdtls").setup()
  local to_setup = {
    bashls = {},
    clangd = {},
    cssls = {},
    dockerls = {},
    html = {},
    hls = {},
    jsonls = {
      json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
    },
    kotlin_language_server = {
      kotlin = { formatting = { formatter = "none" } },
    },
    lua_ls = {},
    pylsp = {},
    taplo = {},
    texlab = require("nvimrc.plugins.lsp.texlab"),
    ts_ls = {},
    yamlls = { yaml = { schemaStore = { enable = true } } },
  }
  local conditional_add = {
    ["nil"] = { "nil_ls", {} },
    ["sourcekit-lsp"] = { "sourcekit", {} },
  }
  for exec, lsp_config in pairs(conditional_add) do
    if vim.fn.executable(exec) == 1 then
      to_setup[lsp_config[1]] = lsp_config[2]
    end
  end

  for server, opts in pairs(to_setup) do
    lsp.setup_with_default(server, opts)
  end
end

--- @type LazyPluginSpec[]
return {
  { "neovim/nvim-lspconfig", version = false, config = configure, lazy = false },
  { "folke/neodev.nvim" },
  { "folke/neoconf.nvim", version = false, cmd = "Neoconf", dependencies = { "nvim-lspconfig" } },
  {
    "smjonas/inc-rename.nvim",
    main = "inc_rename",
    --- @type inc_rename.UserConfig
    opts = { save_in_cmdline_history = false },
    keys = {
      {
        "<leader>rn",
        function () return ":IncRename " .. vim.fn.expand("<cword>") end,
        expr = true,
        desc = "LSP Rename",
      },
    },
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
        diagnostic = {
          show_code_action = true,
          extend_relatedInformation = true,
          quit_in_show = { "q", "<esc>", "<C-c>" },
        },
      }
      require("lspsaga").setup(opts)
    end,
  },
  { "b0o/schemastore.nvim" },
}
