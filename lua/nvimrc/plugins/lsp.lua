local function config_lsp(self, opts)
  local lsp = require("nvimrc.lsp")

  local capabilities = require("blink.cmp").get_lsp_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )


  vim.lsp.config("*", {
    on_attach = lsp.lsp_on_attach,
    capabilities = capabilities,
  })


  vim.lsp.enable({
    "bashls",
    "clangd",
    "cssls",
    "dockerls",
    "gopls",
    "html",
    "jdtls",
    "jsonls",
    "kotlin_lsp",
    "lua_ls",
    "neocmake",
    "nil_ls",
    "pyrefly",
    "ruff",
    "sourcekit",
    "taplo",
    "texlab",
    "tinymist",
    "ts_ls",
    "typos_lsp",
    "yamlls",
  })
end

--- @type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  config = config_lsp,
}
