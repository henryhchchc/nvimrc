local M = {}

function M.configure()
    require("toggleterm").setup({})
    local function set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", "<C-\\><C-n>", opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-w>h", "<C-\\><C-n><C-w>h", opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-w>j", "<C-\\><C-n><C-w>j", opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-w>k", "<C-\\><C-n><C-w>k", opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-w>l", "<C-\\><C-n><C-w>l", opts)
    end

    vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*toggleterm#*",
        callback = set_terminal_keymaps,
    })
    vim.api.nvim_set_keymap("n", "<leader>tt", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true, desc = "Toggle Terminal" })
end

return M
