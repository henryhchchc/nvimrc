--- @type LazyPluginSpec
return {
  "phaazon/hop.nvim",
  keys = {
    {
      "f",
      function() require("hop").hint_char1() end,
      remap = true,
      mode = { "n", "v", "o" },
    },
    {
      "F",
      function() require("hop").hint_char1() end,
      remap = true,
      mode = { "n", "v", "o" },
    },
    {
      "t",
      function() require("hop").hint_char1({ hint_offset = -1 }) end,
      remap = true,
      mode = { "n", "v", "o" },
    },
    {
      "T",
      function() require("hop").hint_char1({ hint_offset = 1 }) end,
      remap = true,
      mode = { "n", "v", "o" },
    },
  },
  config = true,
  event = { "BufNewFile", "BufReadPost" }
}
