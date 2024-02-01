local terminal = {
  background = "#151515",
  alt_background = "#1F1F1F",
}

--- @type CtpIntegrations
local catppuccin_integrations = {
  bufferline = true,
  cmp = true,
  illuminate = true,
  indent_blankline = { enabled = true },
  lsp_trouble = true,
  lsp_saga = true,
  hop = true,
  markdown = true,
  native_lsp = { enabled = true },
  navic = { enabled = true, custom_bg = "NONE" },
  neogit = true,
  neotree = true,
  neotest = true,
  noice = true,
  notify = true,
  nvimtree = false,
  semantic_tokens = true,
  telescope = true,
  treesitter = true,
  treesitter_context = true,
  ts_rainbow2 = true,
  which_key = true,
}

local function mocha_overrides(colors)
  return {
    NormalFloat = { bg = colors.base },
    NotifyBackground = { bg = "#000000" },
    -- Telescope
    TelescopePromptTitle = { bg = colors.blue, fg = colors.base, style = { "bold" } },
    TelescopeResultsTitle = { bg = colors.lavender, fg = colors.base, style = { "bold" } },
    TelescopePreviewTitle = { bg = colors.green, fg = colors.base, style = { "bold" } },

    ["@comment.error"] = { fg = colors.red, bg = colors.none, style = { "bold" } },
    ["@comment.warning"] = { fg = colors.yellow, bg = colors.none, style = { "bold" } },
    ["@comment.todo"] = { fg = colors.peach, bg = colors.none, style = { "bold" } },
    ["@comment.note"] = { fg = colors.blue, bg = colors.none, style = { "bold" } },
  }
end

--- @type CatppuccinOptions
local catppuccin_opts = {
  transparent_background = true,
  term_colors = false,
  show_end_of_buffer = true,
  highlight_overrides = {
    mocha = mocha_overrides,
  },
  color_overrides = {
    mocha = {
      base = terminal.background,
    },
  },
  integrations = catppuccin_integrations,
}

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  opts = catppuccin_opts,
  config = function (_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
