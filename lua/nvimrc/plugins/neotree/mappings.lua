local M = {}

M.filesystem = {
  ["rn"] = "rename",
  ["a"] = {
    "add",
    config = {
      show_path = "relative",
    },
  },
  ["H"] = "toggle_hidden",
  ["A"] = "add_directory",
  ["D"] = "delete",
  ["y"] = "copy_to_clipboard",
  ["d"] = "cut_to_clipboard",
  ["p"] = "paste_from_clipboard",
}

M.window = {
  ["<space>"] = "toggle_node",
  ["<2-LeftMouse>"] = "open",
  ["<cr>"] = "open",
  ["P"] = { "toggle_preview", config = { use_float = true } },
  ["l"] = "focus_preview",
  ["S"] = "open_split",
  ["v"] = "open_vsplit",
  ["t"] = "open_tabnew",
  ["w"] = "open_with_window_picker",
  ["C"] = "close_node",
  ["z"] = "close_all_nodes",
  ["q"] = "close_window",
  ["R"] = "refresh",
  ["?"] = "show_help",
  ["<"] = "prev_source",
  [">"] = "next_source",
  ["K"] = "show_file_details",
  ["<esc>"] = "cancel",
}

return M
