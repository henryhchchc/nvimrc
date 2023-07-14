local M = {}

function M.setupRustAnalyzer()
    local defaultOpts = require("nvimrc.dev.lsp").makeDefaultOpts()
    local rustConfig = {
        server = defaultOpts,
        dap = {
            adapter = {
                type = "executable",
                command = "lldb-vscode",
                name = "rt_lldb",
            },
        },
    }
    require("rust-tools").setup(rustConfig)
end

function M.setupDefaults(serversToConfigure)
    local lspConfig = require("lspconfig")
    local defaultOpts = require("nvimrc.dev.lsp").makeDefaultOpts()
    for _, lsp in pairs(serversToConfigure) do
        lspConfig[lsp].setup(defaultOpts)
    end
end

return M
