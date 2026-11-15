local configured = false

local function find_files()
  local theme = require("telescope.themes").get_dropdown({
    previewer = false,
    prompt_title = "Search Project Files",
    layout_config = {
      width = 0.75,
      height = 0.8,
    },
  })

  require("telescope.builtin").find_files(theme)
end

local keys = {
  { "<leader>ff", find_files, desc = "Telescope Find Files" },
  { "<leader>fg", "live_grep", desc = "Telescope Live grep" },
  { "<leader>fb", "buffers", desc = "Telescope Find Buffer" },
  { "<leader>fh", "help_tags", desc = "Telescope Find Help" },
  { "<leader>fd", "diagnostics", desc = "Telescope List Diagnostics" },
  { "<leader>fm", "man_pages", desc = "Telescope Find Man Pages" },
  { "gs", "lsp_document_symbols", desc = "Document Symbols" },
  { "gS", "lsp_workspace_symbols", desc = "Workspace Symbols" },
  { "z=", "spell_suggest", desc = "Telescope Spell Suggestions" },
}

local function setup()
  if configured then
    return
  end
  local actions = require("telescope.actions")
  local mappings = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
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
      mappings = {
        i = mappings,
        n = vim.tbl_extend("force", mappings, { ["<C-c>"] = actions.close }),
      },
    },
  })
  configured = true
end

for _, key in ipairs(keys) do
  vim.keymap.set("n", key[1], function ()
    setup()
    if type(key[2]) == "function" then
      key[2]()
    else
      require("telescope.builtin")[key[2]]()
    end
  end, { desc = key.desc })
end
