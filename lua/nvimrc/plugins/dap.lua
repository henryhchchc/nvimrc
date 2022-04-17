--- @type LazyKeys[]
local keymaps = {
  {
    "<leader>dB",
    function () package.loaded.dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    desc = "Breakpoint Condition",
  },
  { "<leader>db", function () package.loaded.dap.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
  { "<leader>dc", function () package.loaded.dap.continue() end, desc = "Continue" },
  { "<leader>dC", function () package.loaded.dap.run_to_cursor() end, desc = "Run to Cursor" },
  { "<leader>dg", function () package.loaded.dap.goto_() end, desc = "Go to line (no execute)" },
  { "<leader>di", function () package.loaded.dap.step_into() end, desc = "Step Into" },
  { "<leader>dj", function () package.loaded.dap.down() end, desc = "Down" },
  { "<leader>dk", function () package.loaded.dap.up() end, desc = "Up" },
  { "<leader>dl", function () package.loaded.dap.run_last() end, desc = "Run Last" },
  { "<leader>do", function () package.loaded.dap.step_out() end, desc = "Step Out" },
  { "<leader>dO", function () package.loaded.dap.step_over() end, desc = "Step Over" },
  { "<leader>dp", function () package.loaded.dap.pause() end, desc = "Pause" },
  { "<leader>dr", function () package.loaded.dap.repl.toggle() end, desc = "Toggle REPL" },
  { "<leader>ds", function () package.loaded.dap.session() end, desc = "Session" },
  { "<leader>dt", function () package.loaded.dap.terminate() end, desc = "Terminate" },
  { "<leader>dw", function () package.loaded.dap.ui.widgets.hover() end, desc = "Widgets" },
}

local function configure()
  local dap = require("dap")
  local dapui = require("dapui")

  dap.listeners.before.attach.dapui_config = function () dapui.open() end
  dap.listeners.before.launch.dapui_config = function () dapui.open() end
  dap.listeners.before.event_terminated.dapui_config = function () dapui.close() end
  dap.listeners.before.event_exited.dapui_config = function () dapui.close() end

  dap.adapters.lldb = {
    type = "executable",
    command = "lldb-dap",
    name = "lldb",
  }
end

--- @type LazyPluginSpec[]
return {
  {
    "mfussenegger/nvim-dap",
    main = "dap",
    config = configure,
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text", config = true },
    },
    keys = keymaps,
    event = "LspAttach",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    main = "dapui",
    config = true,
    keys = {
      { "<leader>du", function () package.loaded.dapui.toggle({}) end, desc = "Dap UI" },
      { "<leader>de", function () package.loaded.dapui.eval() end, desc = "Eval", mode = { "n", "v" } },
    },
  },
}
