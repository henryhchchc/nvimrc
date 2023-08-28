--- @type LazyPluginSpec
return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = {
      enabled = true,
      auto_terigger = true,
      keymap = {
        accept = false,
        accept_word = false,
        accept_line = false,
        next = false,
        prev = false,
        dismiss = "<C-]>",
      },
    },
    panel = {
      enabled = true,
    },
  },
  cmd = "Copilot",
  event = "VeryLazy",
}
