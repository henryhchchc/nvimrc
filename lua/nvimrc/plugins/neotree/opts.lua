local components = require("nvimrc.plugins.neotree.components")
local document_symbols = require("nvimrc.plugins.neotree.document_symbols")
local mappings = require("nvimrc.plugins.neotree.mappings")
local sources = require("nvimrc.plugins.neotree.sources")

return {
  sources = sources.names,
  open_files_do_not_replace_types = {
    "terminal",
    "qf",
    "Outline",
    "neotest-summary",
    "neotest-output-panel",
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
      mappings = mappings.filesystem,
    },
  },
  window = {
    mappings = mappings.window,
  },
  default_component_configs = components,
  source_selector = {
    winbar = false,
    statusline = false,
    show_scrolled_off_parent_node = false,
    sources = sources.selector,
  },
  document_symbols = {
    kinds = document_symbols,
  },
}
