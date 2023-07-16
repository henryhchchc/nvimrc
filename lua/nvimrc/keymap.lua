local M = {}

function M.configure()
    vim.keymap.set({ "n", "v", "o" }, "<C-c>", "<esc>")

    vim.keymap.set({ "n", "v", "i" }, "<C-s>", vim.cmd.write, { desc = "Save the file" })

    vim.keymap.set("n", "]t", vim.cmd.tabnext, { desc = "Switch to the next tabpage." })
    vim.keymap.set("n", "[t", vim.cmd.tabprev, { desc = "Switch to the previous tabpage." })
    vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew, { desc = "Create a new tabpage." })
    vim.keymap.set("n", "<leader>tc", vim.cmd.tabclose, { desc = "Close the current tabpage." })

    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to the previous diagnostics" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to the next diagnostics" })
    vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Send diagnostics to quickfix list" })

    vim.keymap.set("n", "]c", vim.cmd.cnext, { desc = "Go to the next quickfix location." })
    vim.keymap.set("n", "[c", vim.cmd.cprev, { desc = "Go to the previous quickfix loaction." })

    -- Moving selection
    vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move Selection Down" })
    vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move Selection Up" })
    vim.keymap.set("n", "<leader>gq", vim.cmd.copen, { desc = "Open Quickfix Window" })
    vim.keymap.set("n", "<leader>gl", vim.cmd.lopen, { desc = "Open Loclist Window" })
    vim.keymap.set("n", "H", "^", { desc = "Start of line (non-blank)" })
    vim.keymap.set("n", "L", "$", { desc = "End of line" })

    -- Terminal mode
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Normal Mode" })

    -- Disable the arrow keys.
    -- Use the home row instead
    vim.keymap.set({ "i", "c" }, "<C-h>", "<Left>")
    vim.keymap.set({ "i", "c" }, "<C-j>", "<Down>")
    vim.keymap.set({ "i", "c" }, "<C-k>", "<Up>")
    vim.keymap.set({ "i", "c" }, "<C-l>", "<Right>")

    vim.keymap.set({ "n", "i", "c", "v", "o" }, "<Up>", "<Nop>")
    vim.keymap.set({ "n", "i", "c", "v", "o" }, "<Down>", "<Nop>")
    vim.keymap.set({ "n", "i", "c", "v", "o" }, "<Left>", "<Nop>")
    vim.keymap.set({ "n", "i", "c", "v", "o" }, "<Right>", "<Nop>")

    -- Disable the annoying q mappings
    vim.keymap.set({ "n", "v", "o" }, "q:", "<Nop>")
    vim.keymap.set({ "n", "v", "o" }, "Q", "q", { desc = "Recoed macro" })
    vim.keymap.set({ "n", "v", "o" }, "q", "<Nop>")
end

return M
