local lsp = require("nvimrc.lsp")

local to_setup = {
  bashls = {},
  clangd = {},
  cssls = {},
  dockerls = {},
  html = {},
  hls = {},
  jsonls = function ()
    return {
      json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
    }
  end,
  kotlin_language_server = {
    kotlin = { formatting = { formatter = "none" } },
  },
  lua_ls = {},
  pylsp = {},
  taplo = {},
  texlab = require("nvimrc.lsp.texlab"),
  ts_ls = {},
  yamlls = { yaml = { schemaStore = { enable = true } } },
}
local conditional_add = {
  ["nil"] = { "nil_ls", {} },
  ["sourcekit-lsp"] = { "sourcekit", {} },
  ["zls"] = { "zls", {} },
}
for exec, lsp_config in pairs(conditional_add) do
  if vim.fn.executable(exec) == 1 then
    to_setup[lsp_config[1]] = lsp_config[2]
  end
end

for server, opts in pairs(to_setup) do
  local options = {}
  if type(opts) == "table" then
    options = opts
  elseif type(opts) == "function" then
    options = opts()
  end
  lsp.setup_with_default(server, options)
end

lsp.setup_with_default("typos_lsp", nil, {
  diagnosticSeverity = "Hint",
})

require("nvimrc.lsp.jdtls").setup()
