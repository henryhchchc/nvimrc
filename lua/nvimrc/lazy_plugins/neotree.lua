local tree_keymaps = {
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

local common_keymaps = {
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

local neotreeOpts = {
  sources = { "filesystem", "buffers", "git_status", "document_symbols" },
  open_files_do_not_replace_types = {
    "terminal",
    "qf",
    "Outline",
    "neotest-summary",
    "neotest-output-panel",
    "sagaoutline",
    "toggleterm",
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
      mappings = tree_keymaps,
    },
  },
  window = {
    mappings = common_keymaps,
  },
  default_component_configs = {
    indent = {
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_empty = "󰜌",
      folder_empty_open = "󰜌",
      default = "",
    },
    git_status = {
      symbols = {
        renamed = "󰁕",
        unstaged = "󰄱",
      },
    },
  },
  source_selector = {
    winbar = false,
    statusline = false,
    show_scrolled_off_parent_node = false,
    sources = {
      { source = "filesystem", display_name = "File System" },
      { source = "buffers", display_name = "Buffers" },
      { source = "git_status", display_name = "Git Status" },
      { source = "document_symbols", display_name = "Document Symbols" },
    },
  },
  document_symbols = {
    kinds = {
      File = { icon = "󰈙", hl = "Tag" },
      Namespace = { icon = "󰌗", hl = "Include" },
      Package = { icon = "󰏖", hl = "Label" },
      Class = { icon = "󰌗", hl = "Include" },
      Property = { icon = "󰆧", hl = "@property" },
      Enum = { icon = "󰒻", hl = "@number" },
      Function = { icon = "󰊕", hl = "Function" },
      String = { icon = "󰀬", hl = "String" },
      Number = { icon = "󰎠", hl = "Number" },
      Array = { icon = "󰅪", hl = "Type" },
      Object = { icon = "󰅩", hl = "Type" },
      Key = { icon = "󰌋", hl = "" },
      Struct = { icon = "󰌗", hl = "Type" },
      Operator = { icon = "󰆕", hl = "Operator" },
      TypeParameter = { icon = "󰊄", hl = "Type" },
      StaticMethod = { icon = "󰠄 ", hl = "Function" },
    },
  },
}

local keymaps = {
  {
    "<leader>e",
    function () require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() }) end,
    desc = "Explorer NeoTree (root dir)",
    remap = true,
  },
}

--- @type LazyPluginSpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = keymaps,
  opts = neotreeOpts,
}
