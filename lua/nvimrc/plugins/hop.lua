--- @type LazyPluginSpec
return {
  "phaazon/hop.nvim",
  keys = {
    {
      "<leader>hw",
      function() require("hop").hint_words() end,
      desc = "Hop to word",
    },
    {
      "<leader>hp",
      function() require("hop").hint_patterns() end,
      desc = "Hop to pattern",
    },
  },
  config = true,
  event = { "BufNewFile", "BufReadPost" },
}
