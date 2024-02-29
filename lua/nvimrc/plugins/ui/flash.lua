--- @type Flash.Config
local options = {
  search = {
    exclude = {
      "notify",
      "cmp_menu",
      "noice",
      "flash_prompt",
      "qf",
      "neo-tree",
      function (win)
        -- exclude non-focusable windows
        return not vim.api.nvim_win_get_config(win).focusable
      end,
    },
    incremental = true,
  },
  modes = { char = { enabled = false } },
}

--- @type LazyKeysSpec[]
local keymaps = {
  {
    "S",
    mode = { "n", "o", "x" },
    function () package.loaded.flash.treesitter() end,
    desc = "Flash Treesitter",
  },
  {
    "r",
    mode = "o",
    function () package.loaded.flash.remote() end,
    desc = "Remote Flash",
  },
  {
    "R",
    mode = { "o", "x" },
    function () package.loaded.flash.treesitter_search() end,
    desc = "Flash Treesitter Search",
  },
  {
    "<c-s>",
    mode = { "c" },
    function () package.loaded.flash.toggle() end,
    desc = "Toggle Flash Search",
  },
}

--- @type LazyPluginSpec
return { "folke/flash.nvim", event = "VeryLazy", opts = options, keys = keymaps }
