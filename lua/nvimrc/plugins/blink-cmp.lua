local colorful_menu = require("colorful-menu")

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
            text = colorful_menu.blink_components_text,
            highlight = colorful_menu.blink_components_highlight,
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

local cmp = require("blink.cmp")
if cmp.library_available() then
  cmp.setup(options)
else
  local progress = require("fidget.progress").handle.create({
    title = "Compiling blink.cmp native library",
    lsp_client = { name = "blink.cmp" },
    cancellable = false,
  })
  cmp.build()
      :schedule()
      :map(function ()
        if not vim.env.CARGO_TARGET_DIR then
          vim.fn.delete(cmp.get_repo_root() .. "/target", "rf")
        end
        cmp.setup(options)
        progress.message = "Ready"
        progress:finish()
      end)
      :catch(vim.schedule_wrap(function (err)
        progress.message = "Failed"
        progress:finish()
        vim.notify("blink.cmp: " .. tostring(err), vim.log.levels.ERROR)
      end))
end
