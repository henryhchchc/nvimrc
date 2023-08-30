--- @type LazyPluginSpec
return {
  "phaazon/hop.nvim",
  --- @param self LazyPlugin
  --- @param keys string[]
  --- @return LazyKeys[]
  keys = {
    {
      "f",
      function()
        local hop = require("hop")
        local dir = require("hop.hint").HintDirection
        hop.hint_char1({ direction = dir.AFTER_CURSOR, current_line_only = true })
      end,
      remap = true,
      mode = { "n", "v", "o" },
    },
    {
      "F",
      function()
        local hop = require("hop")
        local dir = require("hop.hint").HintDirection
        hop.hint_char1({ direction = dir.BEFORE_CURSOR, current_line_only = true })
      end,
      remap = true,
      mode = { "n", "v", "o" },
    },
    {
      "t",
      function()
        local hop = require("hop")
        local dir = require("hop.hint").HintDirection
        hop.hint_char1({ direction = dir.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end,
      remap = true,
      mode = { "n", "v", "o" },
    },
    {
      "T",
      function()
        local hop = require("hop")
        local dir = require("hop.hint").HintDirection
        hop.hint_char1({ direction = dir.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end,
      remap = true,
      mode = { "n", "v", "o" },
    },
  }
  ,
  config = true,
  event = "VeryLazy"
}
