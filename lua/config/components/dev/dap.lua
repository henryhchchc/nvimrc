local M = {}

local function configureDebuggers()
    local dap = require("dap")
    dap.adapters.lldb = {
        type = "executable",
        command = "lldb-vscode",
        name = "lldb",
    }
end

local function configureDapUI()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open(nil)
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close(nil)
        dap.repl.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close(nil)
        dap.repl.close()
    end
end

function M.configure()
    configureDapUI()
    local dap_virtual_text = require("nvim-dap-virtual-text")
    dap_virtual_text.setup()
    configureDebuggers()
end

function M.on_attach(client, bufnr)
    local dap = require("dap")
    local dapui = require("dapui")
    vim.keymap.set("n", "<leader>td", dapui.toggle, { buffer = bufnr, desc = "DAP Toggle UI" })
    vim.keymap.set("n", "<leader>du", dapui.toggle, { buffer = bufnr, desc = "DAP Toggle UI" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { buffer = bufnr, desc = "DAP Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { buffer = bufnr, desc = "DAP Continue" })
    vim.keymap.set("n", "<leader>dsi", dap.step_into, { buffer = bufnr, desc = "DAP Step Into" })
    vim.keymap.set("n", "<leader>dso", dap.step_over, { buffer = bufnr, desc = "DAP Step Over" })
    vim.keymap.set("n", "<leader>dst", dap.step_out, { buffer = bufnr, desc = "DAP Step Out" })
end

return M
