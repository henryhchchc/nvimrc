---@type blink.cmp.Config
local options = {
  completion = {
    list = {
      selection = {
        preselect = function (ctx)
          return ctx.mode ~= "cmdline"
        end,
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 1000,
    },
    menu = {
      draw = {
        columns = { { "kind_icon" }, { "label", gap = 1 } },
        components = {
          label = {
            text = function (ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function (ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        },
      },
    },
  },
  signature = {
    enabled = true,
    window = {
      show_documentation = true,
    },
  },
  keymap = {
    preset = "none",

    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-c>"] = { "hide", "fallback" },
    ["<CR>"] = { "accept", "fallback" },

    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },

    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },

    ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
  },
  cmdline = {
    completion = { ghost_text = { enabled = true } },
    keymap = {
      preset = "cmdline",

      ["<C-c>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept_and_enter", "fallback" },

      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
  },
}

-- Defer until after startup when a UI is present. VeryLazy is emitted on
-- UIEnter, which never happens headless, so fall back to reading a buffer.
-- Keep this in sync with nvim-lspconfig, which depends on blink.cmp.
local event = require("lazy.core.config").headless()
    and { "BufReadPre", "BufNewFile" }
  or "VeryLazy"

--- @type LazyPluginSpec
return {
  "saghen/blink.cmp",
  branch = "main",
  event = event,
  dependencies = {
    { "saghen/blink.lib" },
    { "xzbdmw/colorful-menu.nvim" },
  },
  build = function ()
    require("blink.cmp").build():pwait()
  end,
  opts = options,
  config = function (_plugin, opts)
    require("blink.cmp").setup(opts)
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function ()
        local copilot = package.loaded["copilot.suggestion"]
        if copilot then
          copilot.dismiss()
        end
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuClose",
      callback = function ()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
}
