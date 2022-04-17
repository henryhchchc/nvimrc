--- @type LazyPluginSpec
return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = false,
        accept_word = "<C-l>",
        accept_line = "<C-f>",
        next = "<C-n>",
        prev = "<C-p>",
        dismiss = "<C-]>",
      },
    },
    panel = {
      enabled = true,
    },
  },
  cmd = "Copilot",
  event = "InsertEnter",
}
