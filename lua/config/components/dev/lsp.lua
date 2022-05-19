local dap = require("config.components.dev.dap")

local M = {}

local function setupHighlight(client, bufnr)
    if client.resolved_capabilities.document_highlight then
        vim.cmd("TSBufDisable refactor.highlight_definitions")
        local lspHightlightGrp = vim.api.nvim_create_augroup("lsp_document_highlight", {})
        vim.api.nvim_create_autocmd("CursorHold", {
            group = lspHightlightGrp,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = lspHightlightGrp,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

local function setupFormatting(client, bufnr)
    if client.resolved_capabilities.document_formatting then
        vim.keymap.set("n", "<leader>fm", vim.lsp.buf.formatting, { buffer = bufnr, desc = "LSP Formatting" })
        local lspFormatGrp = vim.api.nvim_create_augroup("lsp_auto_format", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lspFormatGrp,
            buffer = bufnr,
            callback = vim.lsp.buf.formatting_seq_sync,
        })
    end

    if client.resolved_capabilities.document_range_formatting then
        vim.keymap.set("v", "<leader>fm", vim.lsp.buf.range_formatting, { buffer = bufnr, desc = "LSP Range Formatting" })
    end
end

local function setupEditingKepmaps(buf)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buf, desc = "LSP Declaration" })

    local telescope = require("telescope.builtin")
    vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = buf, desc = "LSP Definitions" })
    vim.keymap.set("n", "gD", function()
        telescope.lsp_definitions({ jump_type = "vsplit" })
    end, { buffer = buf, desc = "LSP Definitions (vsplit)" })
    vim.keymap.set("n", "gi", telescope.lsp_implementations, { buffer = buf, desc = "LSP Implementations" })
    vim.keymap.set("n", "gr", telescope.lsp_references, { buffer = buf, desc = "LSP References" })
    vim.keymap.set("n", "<leader>fsw", telescope.lsp_workspace_symbols, { buffer = buf, desc = "LSP Workspace Symbols" })
    vim.keymap.set("n", "<leader>fsd", telescope.lsp_document_symbols, { buffer = buf, desc = "LSP Document Symbols" })
    vim.keymap.set("n", "ge", telescope.diagnostics, { buffer = buf, desc = "LSP Diagnostics" })

    local lspSagaCodeAction = require("lspsaga.codeaction")
    vim.keymap.set("n", "ga", lspSagaCodeAction.code_action, { buffer = buf, desc = "LSP Code Actions" })
    vim.keymap.set("v", "ga", lspSagaCodeAction.range_code_action, { buffer = buf, desc = "LSP Range Code Actions" })

    local lspSagaSigHelp = require("lspsaga.signaturehelp")
    vim.keymap.set("n", "gs", lspSagaSigHelp.signature_help, { buffer = buf, desc = "LSP Signature Help" })

    local lspSagaHover = require("lspsaga.hover")
    vim.keymap.set("n", "K", lspSagaHover.render_hover_doc, { buffer = buf, desc = "LSP Hover Doc" })

    local lspSagaDiagnostic = require("lspsaga.diagnostic")
    vim.keymap.set("n", "go", lspSagaDiagnostic.show_line_diagnostics, { buffer = buf, desc = "LSP Line Diagnostics" })
    vim.keymap.set("n", "[d", lspSagaDiagnostic.navigate("prev"), { buffer = buf, desc = "LSP Previous Diagnostics" })
    vim.keymap.set("n", "]d", lspSagaDiagnostic.navigate("next"), { buffer = buf, desc = "LSP Next Diagnostics" })

    local lspsagaRename = require("lspsaga.rename")
    vim.keymap.set("n", "rn", lspsagaRename.rename, { buffer = buf, desc = "LSP Rename" })
end

local function onAttach(client, bufnr)
    setupHighlight(client, bufnr)
    setupFormatting(client, bufnr)
    setupEditingKepmaps(bufnr)
    dap.on_attach(client, bufnr)
end

local function loadProjectLocalConfig()
    local projectLocalConfig = {}
    local pwd = vim.fn.getcwd()
    local configFunc = loadfile(pwd .. "/.nvim/lsp.lua")
    if configFunc then
        local succ, result = pcall(configFunc)
        if not succ then
            vim.notify("Error when executing .nvim/lsp.lua.", vim.log.levels.ERROR, { title = "LSP Config" })
        elseif type(projectLocalConfig) ~= "table" then
            vim.notify("Project local LSP config should return be a table.", vim.log.levels.ERROR, { title = "LSP Config" })
        else
            vim.notify("Project local LSP config loaded.", vim.log.levels.INFO, { title = "LSP Config" })
            projectLocalConfig = result
        end
    end
    return projectLocalConfig
end

function M.configure()
    local initialCaps = vim.lsp.protocol.make_client_capabilities()
    local clientCaps = require("cmp_nvim_lsp").update_capabilities(initialCaps)

    local serverOpts = {
        on_attach = onAttach,
        capabilities = clientCaps,
    }

    local lspConfig = require("lspconfig")

    local projectLocalConfig = loadProjectLocalConfig()

    local clangdConfig = vim.tbl_deep_extend("force", serverOpts, projectLocalConfig.clangd or {})
    require("clangd_extensions").setup({ server = clangdConfig })

    local rustAnalyzerConfig = vim.tbl_deep_extend("force", serverOpts, projectLocalConfig.rust_analyzer or {})
    require("rust-tools").setup({ server = rustAnalyzerConfig })

    local nullLs = require("null-ls")
    local nullLSDefault = {
        log = { enable = false },
        sources = {
            nullLs.builtins.code_actions.proselint,
            nullLs.builtins.diagnostics.proselint,
            nullLs.builtins.formatting.prettier,
            nullLs.builtins.hover.dictionary,
        },
    }
    local nullLsConfig = vim.tbl_deep_extend("force", serverOpts, nullLSDefault, projectLocalConfig["null-ls"] or {})
    nullLs.setup(nullLsConfig)

    local servers = {
        "hls",
        "jdtls",
        "kotlin_language_server",
        "sumneko_lua",
        "sourcekit",
        "texlab",
    }
    for _, lsp in pairs(servers) do
        local projectLocalConfigPreLsp = projectLocalConfig[lsp] or {}
        local serverConfig = vim.tbl_deep_extend("force", serverOpts, projectLocalConfigPreLsp)
        lspConfig[lsp].setup(serverConfig)
    end

    vim.diagnostic.config({
        virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })
end

return M
