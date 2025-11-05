local function config_telescope(_plugin, _opts)
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local themes = require("telescope.themes")

  local sharedMappings = {
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
    ["<C-w>"] = function () vim.cmd("normal! bcw") end,
  }

  local find_files_command = {
    "fd",
    "--type",
    "f",
    "--strip-cwd-prefix",
    "--hidden",
    "--exclude",
    ".git/",
    "--exclude",
    ".git",
  }

  local find_files_theme = themes.get_dropdown({
    previewer = false,
    prompt_title = "Search Project Files",
    layout_config = {
      width = 0.75,
      height = 0.8,
    },
  })

  telescope.setup({
    pickers = {
      spell_suggest = { theme = "cursor" },
      find_files = {
        find_command = find_files_command,
        theme = "dropdown",
      },
      help_tags = {
        mappings = { i = { ["<CR>"] = actions.select_vertical } },
      },
    },
    defaults = {
      sorting_strategy = "ascending",
      layout_strategy = "flex",
      layout_config = {
        prompt_position = "top",
      },
      winblend = 10,
      scroll_strategy = "limit",
      default_mappings = {
        i = vim.tbl_deep_extend("force", sharedMappings, {}),
        n = vim.tbl_deep_extend("force", sharedMappings, {
          ["<esc>"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
        }),
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      ast_grep = {
        command = { "sg", "--json=stream" },
        grep_open_files = false,
        lang = nil,
      },
    },
  })
  -- telescope.load_extension("fzf")

  telescope.builtin = require("telescope.builtin")

  local function find_files() telescope.builtin.find_files(find_files_theme) end
  vim.keymap.set("n", "<leader>ff", find_files, { desc = "Telescope Find Files" })
  vim.keymap.set("n", "<leader>fg", telescope.builtin.live_grep, { desc = "Telescope Live grep" })
  vim.keymap.set("n", "<leader>fb", telescope.builtin.buffers, { desc = "Telescope Find Buffer" })
  vim.keymap.set("n", "<leader>fh", telescope.builtin.help_tags, { desc = "Telescope Find Help" })
  vim.keymap.set("n", "<leader>fd", telescope.builtin.diagnostics, { desc = "Telescope List Diagnostics" })
  vim.keymap.set("n", "<leader>fm", telescope.builtin.man_pages, { desc = "Telescope Find Man Pages" })

  vim.keymap.set("n", "<leader>gS", telescope.builtin.lsp_document_symbols, { desc = "Document Symbols" })
  vim.keymap.set("n", "<leader>gw", telescope.builtin.lsp_workspace_symbols, { desc = "Workspace Symbols" })

  vim.keymap.set("n", "z=", telescope.builtin.spell_suggest, { desc = "Telescope Spell Suggestions" })
end

--- @type LazyPluginSpec
return {
  "nvim-telescope/telescope.nvim",
  event = "UIEnter",
  config = config_telescope,
}
