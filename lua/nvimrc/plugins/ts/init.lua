---@type TSConfig
local treeSitterOptions = {
  ensure_installed = require("nvimrc.plugins.ts.languages"),
  ignore_install = {},
  --- @type TSModule
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  --- @type TSModule
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      node_decremental = "<bs>",
    },
  },
  --- @type TSModule
  indent = {
    enable = true,
  },
  --- @type TSModule
  textobjects = {
    enable = true,
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["as"] = "@statement.outer",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["aa"] = "@prarmeter.outer",
        ["ia"] = "@prarmeter.inner",
      },
    },
  },
  --- @type TSModule
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  --- @type TSModule
  autotag = { enable = true },
  --- @type TSModule
  rainbow = { enable = true },
}

local function configureTreeSitter()
  require("nvim-treesitter.configs").setup(treeSitterOptions)
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt.foldenable = false
end

--- @type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "windwp/nvim-ts-autotag" },
      { "HiPhish/nvim-ts-rainbow2" },
    },
    build = ":TSUpdate",
    config = configureTreeSitter,
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { max_join_length = 1024, use_default_keymaps = false },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>j", function() require("treesj").toggle() end, desc = "Toggle node folding" },
    },
  },
}
