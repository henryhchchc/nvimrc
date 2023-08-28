--- @type NoiceConfig
local options = {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
    {
      filter = {
        event = "msg_show",
        any = {
          {find = "[nvim-treesitter]"},
          { kind = "echo" },
          { kind = "echomsg" },
        },
      },
      view = "mini",
    },
  },
  views = {
    vsplit = {
      size = "40%",
      enter = true,
    },
  },
}

--- @type LazyPluginSpec
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = options,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
    "nvim-treesitter/nvim-treesitter",
  },
}
