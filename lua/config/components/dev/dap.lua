local M = {}


local function configureDebuggers()
    local dap = require("dap")
    dap.adapters.lldb = {
        type = 'executable',
        command = 'lldb-vscode',
        name = "lldb"
    }
end

function M.configure()
    local dap, dapui = require("dap"), require("dapui")
    local dap_virtual_text = require("nvim-dap-virtual-text")

    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
    dap_virtual_text.setup()
    configureDebuggers()
end

function M.on_attach(client, bufnr)

    local dap, dapui = require("dap"), require("dapui")
    vim.keymap.set("n", "<leader>td", dapui.toggle, { buffer = bufnr, desc = "DAP Toggle UI" })
    vim.keymap.set("n", "<leader>du", dapui.toggle, { buffer = bufnr, desc = "DAP Toggle UI" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { buffer = bufnr, desc = "DAP Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { buffer = bufnr, desc = "DAP Continue" })
    vim.keymap.set("n", "<leader>dsi", dap.step_into, { buffer = bufnr, desc = "DAP Step Into" })
    vim.keymap.set("n", "<leader>dso", dap.step_over, { buffer = bufnr, desc = "DAP Step Over" })
    vim.keymap.set("n", "<leader>dst", dap.step_out, { buffer = bufnr, desc = "DAP Step Out" })

end

return M
