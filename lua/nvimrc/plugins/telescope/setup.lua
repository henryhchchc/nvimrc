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
    ["<C-w>"] = function ()
      vim.cmd("normal! bcw")
    end,
  }
end

function M.setup()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local mappings = shared_mappings(actions)

  telescope.setup({
    pickers = {
      spell_suggest = { theme = "cursor" },
      find_files = { theme = "dropdown" },
      help_tags = {
        mappings = { i = { ["<CR>"] = actions.select_vertical } },
      },
    },
    defaults = {
      file_ignore_patterns = { "^.git/?" },
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
    },
  })
end

return M
