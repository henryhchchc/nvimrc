local pickers = require("nvimrc.plugins.telescope.pickers")

return {
  { "<leader>ff", pickers.find_files, desc = "Telescope Find Files" },
  { "<leader>fg", pickers.live_grep, desc = "Telescope Live grep" },
  { "<leader>fb", pickers.buffers, desc = "Telescope Find Buffer" },
  { "<leader>fh", pickers.help_tags, desc = "Telescope Find Help" },
  { "<leader>fd", pickers.diagnostics, desc = "Telescope List Diagnostics" },
  { "<leader>fm", pickers.man_pages, desc = "Telescope Find Man Pages" },
  { "<leader>gS", pickers.document_symbols, desc = "Document Symbols" },
  { "<leader>gw", pickers.workspace_symbols, desc = "Workspace Symbols" },
  { "z=", pickers.spell_suggest, desc = "Telescope Spell Suggestions" },
}
