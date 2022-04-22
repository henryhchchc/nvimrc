local dap = require("config.components.dev.dap")

local M = {}

local function setupHighlight(client, bufnr)
    if client.resolved_capabilities.document_highlight then
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

local function on_attach(client, bufnr)
    setupHighlight(client, bufnr)
    setupFormatting(client, bufnr)
    setupEditingKepmaps(bufnr)
    dap.on_attach(client, bufnr)
end

function M.configure()
    local initialCaps = vim.lsp.protocol.make_client_capabilities()
    local lspCaps = require("cmp_nvim_lsp").update_capabilities(initialCaps)

    local serverOpts = {
        on_attach = on_attach,
        capabilities = lspCaps,
    }

    local lspConfig = require("lspconfig")

    require("clangd_extensions").setup({ server = serverOpts })
    require("rust-tools").setup({ server = serverOpts })

    lspConfig.texlab.setup(vim.tbl_deep_extend("force", serverOpts, {
        settings = {
            checktex = {
                onEdit = true,
                onOpenAndSave = true,
            },
        },
    }))

    local nullLs = require("null-ls")
    nullLs.setup({
        on_attach = on_attach,
        log = { enable = false },
        sources = {
            -- nullLs.builtins.completion.spell,
            nullLs.builtins.formatting.prettier,
            nullLs.builtins.hover.dictionary,
        },
    })

    local servers = { "sourcekit", "sumneko_lua", "hls" }
    for _, lsp in pairs(servers) do
        lspConfig[lsp].setup(serverOpts)
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
