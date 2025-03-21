local lsp = require("nvimrc.lsp")

local setup_with_defaults = {
  "bashls",
  "clangd",
  "cssls",
  "dockerls",
  "gopls",
  "html",
  "hls",
  "lua_ls",
  "neocmake",
  "nil_ls",
  "pylsp",
  "sourcekit",
  "taplo",
  "ts_ls",
  "zls",
}
local lspconfig = require "lspconfig"
lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, function (config)
  if config.name == "sourcekit" then
    config.filetypes = { "swift", "objc", "objcpp" }
  end
end)

for _, server in ipairs(setup_with_defaults) do
  lsp.setup(server, nil, nil)
end

lsp.setup("texlab", require("nvimrc.lsp.texlab"))
lsp.setup("typos_lsp", nil, {
  diagnosticSeverity = "Hint",
})
lsp.setup("tinymist", nil, {
  exportPdf = "onDocumentHasTitle",
  outputPath = "$root/$name",
  formatterMode = "typstyle",
})
lsp.setup("yamlls", {
  yaml = { schemaStore = { enable = true } },
})
lsp.setup("kotlin_language_server", {
  kotlin = { formatting = { formatter = "ktlint" } },
})
lsp.setup("jsonls", {
  json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
})


require("nvimrc.lsp.jdtls").setup()
