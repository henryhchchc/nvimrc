local key_maps = {
  { "<leader>tt", function () package.loaded.neotest.run.run(vim.fn.expand("%")) end, desc = "Run File" },
  { "<leader>tT", function () package.loaded.neotest.run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
  { "<leader>tr", function () package.loaded.neotest.run.run() end, desc = "Run Nearest" },
  { "<leader>ts", function () package.loaded.neotest.summary.toggle() end, desc = "Toggle Summary" },
  {
    "<leader>to",
    function () package.loaded.neotest.output.open({ enter = true, auto_close = true }) end,
    desc = "Show Output",
  },
  { "<leader>tO", function () package.loaded.neotest.output_panel.toggle() end, desc = "Toggle Output Panel" },
  { "<leader>tS", function () package.loaded.neotest.run.stop() end, desc = "Stop" },
}

--- @type LazyPluginSpec
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/nvim-nio",

    -- Test runners
    "mrcjkb/rustaceanvim", -- Rust
  },
  opts = function (_self, _opts)
    local rustacean_test_runner = require("rustaceanvim.neotest")
    --- @type neotest.Config
    return {
      adapters = {
        rustacean_test_runner,
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
