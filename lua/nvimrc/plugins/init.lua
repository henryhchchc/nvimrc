local M = {}

function M.setup()
  require("nvimrc.plugins.catppuccin").setup()
  require("nvimrc.plugins.blink-pairs").setup()
  require("nvimrc.plugins.blink-cmp").setup()
  require("nvimrc.plugins.treesitter").setup()
  require("nvimrc.plugins.fidget").setup()
  require("nvimrc.plugins.lsp").setup()
  require("nvimrc.plugins.gitsigns").setup()
  require("nvimrc.plugins.neotree").setup()
  require("nvimrc.plugins.telescope").setup()
  require("nvimrc.plugins.lualine").setup()
  require("nvimrc.plugins.rust").setup()

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
end

return M
