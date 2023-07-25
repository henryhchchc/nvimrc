local M = {}

local diagnostics = require("nvimrc.dev.lsp.diagnostic")
local jdtls = require("nvimrc.dev.lsp.jdtls")
local keymaps = require("nvimrc.dev.lsp.keymaps")
local servers = require("nvimrc.dev.lsp.servers")
local texlab = require("nvimrc.dev.lsp.texlab")

M.servers = servers

local function lspAttach(client, bufnr) keymaps.setupEditingKepmaps(bufnr) end

function M.makeDefaultOpts()
  local initialCaps = vim.lsp.protocol.make_client_capabilities()
  local cmpCaps = require("cmp_nvim_lsp").default_capabilities()
  local capabilities = vim.tbl_deep_extend("force", initialCaps, cmpCaps)
  local lspFlags = {}
  return {
    on_attach = lspAttach,
    capabilities = capabilities,
    flags = lspFlags,
  }
end

function M.configureServers()
  texlab.configure()
  jdtls.configure()
  servers.setupDefaults({
    "bashls",
    "cssls",
    "jsonls",
    "html",
    "grammarly",
    "hls",
    "kotlin_language_server",
    "lua_ls",
    "nil_ls",
    "sourcekit",
    "pyright",
    "taplo",
    "yamlls",
  })
end

function M.configure()
  diagnostics.configure()

  require("neoconf").setup({})
  require("neodev").setup({})
  M.configureServers()
  require("nvimrc.dev.lsp.efm").configure(M.makeDefaultOpts())
end

return M
