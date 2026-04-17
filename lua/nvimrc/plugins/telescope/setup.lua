local M = {}

local function shared_mappings(actions)
  return {
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
    ["<C-w>"] = function()
      vim.cmd("normal! bcw")
    end,
  }
end

local function find_files_command()
  return {
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
end

function M.setup()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local mappings = shared_mappings(actions)

  telescope.setup({
    pickers = {
      spell_suggest = { theme = "cursor" },
      find_files = {
        find_command = find_files_command(),
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
        i = vim.tbl_deep_extend("force", mappings, {}),
        n = vim.tbl_deep_extend("force", mappings, {
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
end

return M
