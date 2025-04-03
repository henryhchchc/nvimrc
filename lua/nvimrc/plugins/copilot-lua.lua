require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = false,
    keymap = {
      accept = "<M-Tab>",
      accept_word = "<C-l>",
      accept_line = "<C-f>",
      next = "<M-n>",
      prev = "<M-p>",
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
  copilot_model = "gpt-4o-copilot",
})
