local builtin = require("telescope.builtin")

local function find_files()
  local theme = require("telescope.themes").get_dropdown({
    previewer = false,
    prompt_title = "Search Project Files",
    layout_config = {
      width = 0.75,
      height = 0.8,
    },
  })

  builtin.find_files(theme)
end

local keys = {
  { "<leader>ff", find_files, desc = "Telescope Find Files" },
  { "<leader>fg", builtin.live_grep, desc = "Telescope Live grep" },
  { "<leader>fb", builtin.buffers, desc = "Telescope Find Buffer" },
  { "<leader>fh", builtin.help_tags, desc = "Telescope Find Help" },
  { "<leader>fd", builtin.diagnostics, desc = "Telescope List Diagnostics" },
  { "<leader>fm", builtin.man_pages, desc = "Telescope Find Man Pages" },
  { "gs", builtin.lsp_document_symbols, desc = "Document Symbols" },
  { "gS", builtin.lsp_workspace_symbols, desc = "Workspace Symbols" },
  { "z=", builtin.spell_suggest, desc = "Telescope Spell Suggestions" },
}

local actions = require("telescope.actions")
local mappings = {
  ["<C-x>"] = actions.select_horizontal,
  ["<C-v>"] = actions.select_vertical,
  ["<C-t>"] = actions.select_tab,
  ["<C-c>"] = actions.close,
  ["<C-j>"] = actions.move_selection_next,
  ["<C-k>"] = actions.move_selection_previous,
  ["<CR>"] = actions.select_default,
  ["<C-u>"] = actions.preview_scrolling_up,
  ["<C-d>"] = actions.preview_scrolling_down,
  ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
  ["<C-w>"] = function ()
    vim.cmd("normal! bcw")
  end,
}
local telescope = require("telescope")

telescope.setup({
  pickers = {
    spell_suggest = { theme = "cursor" },
    help_tags = {
      mappings = { i = { ["<CR>"] = actions.select_vertical } },
    },
  },
  defaults = {
    file_ignore_patterns = { "%.git/" },
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      prompt_position = "top",
    },
    winblend = 10,
    scroll_strategy = "limit",
    default_mappings = {
      i = mappings,
      n = vim.tbl_deep_extend("force", mappings, {
        ["<esc>"] = actions.close,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
      }),
    },
  },
})
for _, key in ipairs(keys) do
  vim.keymap.set("n", key[1], key[2], { desc = key.desc })
end
