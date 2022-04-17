local M = {}

local keymaps = require("config.components.dev.lsp.keymaps")
local projectLocalSettings = require("config.components.dev.lsp.localsettings")
local servers = require("config.components.dev.lsp.servers")
local texlab = require("config.components.dev.lsp.texlab")
local diagnostics = require("config.components.dev.lsp.diagnostic")

M.servers = servers

local function lspAttach(client, bufnr) keymaps.setupEditingKepmaps(bufnr) end

function M.makeDefaultOpts()
    local initialCaps = vim.lsp.protocol.make_client_capabilities()
    local clientCaps = require("cmp_nvim_lsp").default_capabilities(initialCaps)
    local attach = lspAttach
    local lspFlags = {}
    return {
        on_attach = attach,
        capabilities = clientCaps,
        flags = lspFlags,
    }
end

function M.configureServers()
    vim.g.local_lsp_config = projectLocalSettings.loadProjectLocalConfig()
    texlab.configure()
    servers.setupDefaults({
        "bashls",
        "cssls",
        "jsonls",
        "html",
        "grammarly",
        "hls",
        "kotlin_language_server",
        "lua_ls",
        "sourcekit",
        "pyright",
        "taplo",
        "yamlls",
    })
end

function M.configure()
    diagnostics.configure()
    local lspConfigGrp = vim.api.nvim_create_augroup("lsp-rc-reload", { clear = true })
    vim.api.nvim_create_autocmd("DirChanged", {
        group = lspConfigGrp,
        callback = function() M.configureServers() end,
    })
    M.configureServers()
end

return M
