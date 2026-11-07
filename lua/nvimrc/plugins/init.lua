require("nvimrc.plugins.catppuccin")
require("nvimrc.plugins.blink-pairs")
require("nvimrc.plugins.blink-cmp")
require("nvimrc.plugins.treesitter")
require("fidget").setup()
vim.notify = require("fidget.notification").notify
require("nvimrc.plugins.lsp")
require("nvimrc.plugins.gitsigns")
require("nvimrc.plugins.neotree")
require("nvimrc.plugins.telescope")
require("nvimrc.plugins.lualine")
require("crates").setup({})

require("neogit").setup({
  disable_line_numbers = false,
  graph_style = "unicode",
  commit_editor = { kind = "vsplit" },
  preview_buffer = { kind = "vsplit" },
  popup = { kind = "vsplit" },
})
require("oil").setup()
require("ibl").setup()
require("nvim-surround").setup()
