local copilot_opts = {
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
}

--- @type LazyPluginSpec[]
return {
  {
    "zbirenbaum/copilot.lua",
    opts = copilot_opts,
    config = true,
    event = "InsertEnter",
  },
  { "AndreM222/copilot-lualine" },
}
