--- @type NoiceConfig
local options = {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    documentation = {
      opts = {
        border = {
          style = "rounded",
        },
      },
    },
  },
  popupmenu = { enable = false },
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
          { find = "[nvim-treesitter]" },
          { find = "written$" },
        },
      },
      view = "mini",
    },
    {
      filter = {
        event = "lsp",
        cond = function (message)
          local client = vim.tbl_get(message.opts, "progress", "client")
          return client == "null-ls"
        end,
      },
      opts = { skip = true },
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
