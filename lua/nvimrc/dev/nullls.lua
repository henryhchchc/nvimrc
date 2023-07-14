local M = {}

local function configure()
    local nullLs = require("null-ls")
    nullLs.setup({
        sources = {
            nullLs.builtins.completion.tags,
            nullLs.builtins.diagnostics.ruff,
            nullLs.builtins.formatting.prettier,
            nullLs.builtins.formatting.ruff,
            nullLs.builtins.formatting.swiftformat,
            nullLs.builtins.hover.dictionary,
        },
        on_attach = require("nvimrc.dev.lsp").lspAttach,
    })
end

M.pluginSpec = { "jose-elias-alvarez/null-ls.nvim", config = configure, event = "VeryLazy" }

return M
