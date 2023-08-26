return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>hh",
      function() require("harpoon.ui").toggle_quick_menu() end,
      desc = "Harpoon",
    },
    {
      "<leader>ha",
      function() require("harpoon.mark").add_file() end,
      desc = "Add Current File to Harpoon",
    },
  },
}
