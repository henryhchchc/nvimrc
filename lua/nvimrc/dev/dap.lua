local M = {}

local function configure()
    local dapModule = require("dap")
    local dapuiModule = require("dapui")
    dapuiModule.setup()
    dapModule.listeners.after.event_initialized["dapui_config"] = function() dapuiModule.open({}) end
    dapModule.listeners.before.event_terminated["dapui_config"] = function()
        dapuiModule.close({})
        dapModule.repl.close()
    end
    dapModule.listeners.before.event_exited["dapui_config"] = function()
        dapuiModule.close({})
        dapModule.repl.close()
    end
    local dap_virtual_text = require("nvim-dap-virtual-text")
    dap_virtual_text.setup({})
    dapModule.adapters.lldb = {
        type = "executable",
        command = "lldb-vscode",
        name = "lldb",
    }
    dapModule.adapters.rt_lldb = {
        type = "executable",
        command = "lldb-vscode",
        name = "rt_lldb",
    }

    dapModule.configurations.scala = {
        {
            type = "scala",
            request = "launch",
            name = "[Scala] Run or Test Target",
            metals = {
                runType = "runOrTestFile",
            },
        },
        {
            type = "scala",
            request = "launch",
            name = "[Scala] Test Target",
            metals = {
                runType = "testTarget",
            },
        },
    }
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local bufnr = args.buf
            if args.data then
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                local dap = require("dap")
                local dapui = require("dapui")
                local telescope = require("telescope")
                telescope.load_extension("dap")
                vim.keymap.set("n", "<leader>td", dapui.toggle, { buffer = bufnr, desc = "DAP Toggle UI" })
                vim.keymap.set("n", "<leader>du", dapui.toggle, { buffer = bufnr, desc = "DAP Toggle UI" })
                vim.keymap.set(
                    "n",
                    "<leader>db",
                    dap.toggle_breakpoint,
                    { buffer = bufnr, desc = "DAP Toggle Breakpoint" }
                )
                vim.keymap.set("n", "<leader>dc", dap.continue, { buffer = bufnr, desc = "DAP Continue" })
                vim.keymap.set("n", "<leader>dsi", dap.step_into, { buffer = bufnr, desc = "DAP Step Into" })
                vim.keymap.set("n", "<leader>dso", dap.step_over, { buffer = bufnr, desc = "DAP Step Over" })
                vim.keymap.set("n", "<leader>dst", dap.step_out, { buffer = bufnr, desc = "DAP Step Out" })
                vim.keymap.set(
                    "n",
                    "<leader>dt",
                    telescope.extensions.dap.commands,
                    { desc = "Telescope DAP Commands" }
                )
            end
        end,
    })
end

--- @type LazyPluginSpec
M.pluginSpec = {
    "mfussenegger/nvim-dap",
    config = configure,
    dependencies = { { "rcarriga/nvim-dap-ui" }, { "theHamsta/nvim-dap-virtual-text" } },
    event = "LspAttach",
}

return M
