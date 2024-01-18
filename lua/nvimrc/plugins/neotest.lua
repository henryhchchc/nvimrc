local key_maps = {
  { "<leader>tt", function () require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
  { "<leader>tT", function () require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
  { "<leader>tr", function () require("neotest").run.run() end, desc = "Run Nearest" },
  { "<leader>ts", function () require("neotest").summary.toggle() end, desc = "Toggle Summary" },
  {
    "<leader>to",
    function () require("neotest").output.open({ enter = true, auto_close = true }) end,
    desc = "Show Output",
  },
  { "<leader>tO", function () require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
  { "<leader>tS", function () require("neotest").run.stop() end, desc = "Stop" },
}

--- @type LazyPluginSpec
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- Test runners
    "rouge8/neotest-rust",
  },
  opts = function (self, opts)
    --- @type neotest.Config
    return {
      adapters = {
        require("neotest-rust"),
      },
      status = { virtual_text = true, signs = false },
      output = { open_on_run = true },
      quickfix = {
        open = function () vim.cmd.Trouble("quickfix") end,
      },
    }
  end,
  keys = key_maps,
}
