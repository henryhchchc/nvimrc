require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<Tab>",
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
  filetypes = {
    yaml = true,
    markdown = true,
    help = true,
    gitcommit = true,
    gitrebase = true,
    hgcommit = true,
    svn = true,
    cvs = true,
    ["."] = true,
  },
})
