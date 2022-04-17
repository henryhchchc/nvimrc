local M = {}

function M.setupRustAnalyzer()
    local defaultOpts = require("config.components.dev.lsp").makeDefaultOpts()
    local localConfig = vim.g.local_lsp_config.rust_analyzer or {}
    local finalConfig = vim.tbl_deep_extend("force", defaultOpts, localConfig)
    local rustConfig = {
        server = finalConfig,
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
    local defaultOpts = require("config.components.dev.lsp").makeDefaultOpts()
    for _, lsp in pairs(serversToConfigure) do
        local localConfig = vim.g.local_lsp_config[lsp] or {}
        local serverConfig = vim.tbl_deep_extend("force", defaultOpts, localConfig)
        lspConfig[lsp].setup(serverConfig)
    end
end

return M
