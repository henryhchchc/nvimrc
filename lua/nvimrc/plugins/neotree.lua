local mappings = {}

mappings.filesystem = {
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

mappings.window = {
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

local options = {
  sources = { "filesystem", "buffers", "git_status", "document_symbols" },
  open_files_do_not_replace_types = {
    "terminal",
    "qf",
    "Outline",
  },
  use_popups_for_input = false,
  use_default_mappings = false,
  filesystem = {
    group_empty_dirs = true,
    scan_mode = "deep",
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
    filtered_items = {
      hide_dotfiles = false,
      never_show = {
        ".git",
      },
    },
    window = {
      mappings = mappings.filesystem,
    },
  },
  window = {
    mappings = mappings.window,
  },
  default_component_configs = {
    indent = {
      with_expanders = false,
      expander_collapsed = "",
      expander_expanded = "",
    },
    icon = {
      folder_empty = "󰜌",
      folder_empty_open = "󰜌",
      default = "",
    },
    git_status = {
      symbols = {
        renamed = "󰁕",
        unstaged = "󰄱",
      },
    },
  },
}

require("neo-tree").setup(options)
vim.keymap.set("n", "<leader>e", function ()
  require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
end, { desc = "Explorer NeoTree (root dir)" })
