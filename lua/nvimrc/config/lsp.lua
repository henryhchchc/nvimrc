local lsp = require("nvimrc.lsp")

vim.cmd.packadd("blink.cmp")
local capabilities = require("blink.cmp").get_lsp_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)


vim.lsp.config("*", {
  root_markers = { ".git/" },
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
