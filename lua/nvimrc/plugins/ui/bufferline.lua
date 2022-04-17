--- @type LazyPluginSpec
return {
  "akinsho/bufferline.nvim",
  dependencies = {
    { "echasnovski/mini.bufremove", config = true, event = "VeryLazy" },
    { "tiagovla/scope.nvim", config = true, event = "VeryLazy" },
    { "catppuccin/nvim" },
  },
  opts = function ()
    local groups = require("bufferline.groups")
    --- @type bufferline.UserConfig
    return {
      options = {
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        close_command = function (buf_id) require("mini.bufremove").delete(buf_id, false) end,
        right_mouse_command = function (buf_id) require("mini.bufremove").delete(buf_id, false) end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo Tree",
            highlight = "Title",
            text_align = "center",
          },
        },
        groups = {
          items = {
            groups.builtin.ungrouped,
            {
              name = " Terminals",
              matcher = function (buf) return buf.buftype == "terminal" end,
            },
          },
        },
      },
    }
  end,
  event = "VeryLazy",
  keys = {
    { "<leader>bp", function () vim.cmd.BufferLineTogglePin() end, desc = "Toggle pin" },
    { "<leader>bP", function () vim.cmd.BufferLineGroupClose("ungrouped") end, desc = "Delete non-pinned buffers" },
    { "[b", function () vim.cmd.BufferLineCyclePrev() end, desc = "Previous buffer" },
    { "]b", function () vim.cmd.BufferLineCycleNext() end, desc = "Next buffer" },
  },
}
