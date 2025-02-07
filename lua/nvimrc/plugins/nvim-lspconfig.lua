local lsp = require("nvimrc.lsp")

local setup_with_defaults = {
  "bashls",
  "clangd",
  "cssls",
  "dockerls",
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

for _, server in pairs(setup_with_defaults) do
  lsp.setup(server)
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
