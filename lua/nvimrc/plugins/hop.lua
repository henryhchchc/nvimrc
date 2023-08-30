--- @type LazyPluginSpec
return {
  "phaazon/hop.nvim",
  --- @param self LazyPlugin
  --- @param keys string[]
  --- @return LazyKeys[]
  keys = function(self, keys)
    local hop = require("hop")
    local dir = require("hop.hint").HintDirection
    --- @type LazyKeys[]
    return {
      {
        "f",
        function() hop.hint_char1({ direction = dir.AFTER_CURSOR, current_line_only = true }) end,
        remap = true,
        mode = { "n", "v", "o" },
      },
      {
        "F",
        function() hop.hint_char1({ direction = dir.BEFORE_CURSOR, current_line_only = true }) end,
        remap = true,
        mode = { "n", "v", "o" },
      },
      {
        "t",
        function() hop.hint_char1({ direction = dir.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end,
        remap = true,
        mode = { "n", "v", "o" },
      },
      {
        "T",
        function() hop.hint_char1({ direction = dir.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end,
        remap = true,
        mode = { "n", "v", "o" },
      },
    }
  end,
  config = true,
  event = "VeryLazy"
}
