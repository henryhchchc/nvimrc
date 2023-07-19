local M = {}

function M.setupEditingKepmaps(buf)
    local function buf_map(mode, key, func, desc) vim.keymap.set(mode, key, func, { buffer = buf, desc = desc }) end

    buf_map("n", "gD", vim.lsp.buf.declaration, "LSP Declaration")
    buf_map("n", "gd", function () vim.cmd.Trouble("lsp_definitions") end, "LSP Definitions")
    buf_map("n", "gI", vim.lsp.buf.implementation, "LSP Implementations")
    buf_map("n", "gr", function() vim.cmd.Trouble("lsp_references") end, "LSP References")
    buf_map("n", "gs", vim.lsp.buf.signature_help, "LSP Signagure Help")
    buf_map("i", "<C-k>", vim.lsp.buf.signature_help, "LSP Signagure Help")
    -- Replaced with telescope
    -- buf_map("n", "<leader>gw", vim.lsp.buf.workspace_symbol, "LSP Workspace Symbols")
    -- buf_map("n", "<leader>gs", vim.lsp.buf.document_symbol, "LSP Document Symbols")
    buf_map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP Code Actions")
    buf_map("n", "<leader>gl", vim.lsp.codelens.run, "LSP Run Codelens")
    buf_map("n", "K", vim.lsp.buf.hover, "LSP Hover Doc")
    buf_map({ "n", "v" }, "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "LSP Format")
    buf_map("n", "<leader>rn", vim.lsp.buf.rename, "LSP Rename")
    buf_map("v", "<leader>ca", vim.lsp.buf.code_action, "LSP Range Code Actions")
end

return M
