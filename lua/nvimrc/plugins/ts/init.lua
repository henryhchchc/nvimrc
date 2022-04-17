--- @type TSConfig
local treesitter_opts = {
  ensure_installed = "all",
  ignore_install = require("nvimrc.plugins.ts.skip_languages"),
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
  indent = { enable = true },
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
}


--- @type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "windwp/nvim-ts-autotag" },
    },
    build = ":TSUpdate",
    version = false,
    opts = treesitter_opts,
    event = { "BufReadPost", "BufNewFile" },
    config = function (_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    init = function ()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.fillchars = "fold: "
      vim.opt.foldlevel = 255
    end,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    event = "BufEnter",
    version = false,
    config = function ()
      require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({})
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    --- @type TSContext.Config
    opts = {
      multiline_threshold = 5,
    },
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { max_join_length = 1024, use_default_keymaps = false },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>j", function () package.loaded.treesj.toggle() end, desc = "Toggle node folding" },
    },
  },
}
