local texLabExtraConfig = {
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        -- Please set $pdf_mode in latexmkrc to enable PDF output.
        args = { "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = true,
      },
      chktex = {
        onEdit = false,
        onOpenAndSave = true,
      },
      diagnosticsDelay = 100,
      formatterLineLength = 0,
    },
  },
}

local defaultOpts = require("nvimrc.lsp").lsp_default_opts()
if vim.fn.has("macunix") then
  texLabExtraConfig.settings.texlab.build.forwardSearchAfter = true
  -- Use [Skim](https://skim-app.sourceforge.io) on macOS for forward search.
  texLabExtraConfig.settings.texlab.forwardSearch = {
    executable = "displayline",
    args = { "-b", "-g", "%l", "%p", "%f" },
  }
end
local finalConfig = vim.tbl_deep_extend("force", defaultOpts, texLabExtraConfig)
local lspConfig = require("lspconfig")
lspConfig.texlab.setup(finalConfig)
