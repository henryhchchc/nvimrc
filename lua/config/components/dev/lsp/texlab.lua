local M = {}

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

function M.configure()
    local defaultOpts = require("config.components.dev.lsp").makeDefaultOpts()
    -- local localConfig = vim.g.local_lsp_config.texlab or {}
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
end

M.backwardSearchPluginSpec = {
    "f3fora/nvim-texlabconfig",
    tag = "v0.1.0",
    config = function() require("texlabconfig").setup() end,
    ft = { "tex", "bib" },
    cmd = { "TexlabInverseSearch" },
    -- Skim config:
    -- Command: nvim
    -- Args: --headless -c "TexlabInverseSearch '%file' %line"
}

return M
