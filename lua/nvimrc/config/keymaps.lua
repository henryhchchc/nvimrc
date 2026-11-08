-- Tab pages
vim.keymap.set("n", "]t", vim.cmd.tabnext, { desc = "Switch to the next tabpage." })
vim.keymap.set("n", "[t", vim.cmd.tabprev, { desc = "Switch to the previous tabpage." })
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew, { desc = "Create a new tabpage." })
vim.keymap.set("n", "<leader>tc", vim.cmd.tabclose, { desc = "Close the current tabpage." })

vim.keymap.set("n", "]x", vim.cmd.cnext, { desc = "Go to the next quickfix location." })
vim.keymap.set("n", "[x", vim.cmd.cprev, { desc = "Go to the previous quickfix location." })
vim.keymap.set("n", "<leader>gq", vim.cmd.copen, { desc = "Open Quickfix Window" })
vim.keymap.set("n", "<leader>gl", vim.cmd.lopen, { desc = "Open Loclist Window" })
vim.keymap.set("n", "<leader>gm", vim.cmd.messages, { desc = "Open Messages" })

-- Moving selection
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move Selection Down" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move Selection Up" })

vim.keymap.set("n", "H", "^", { desc = "Start of line (non-blank)" })
vim.keymap.set("n", "L", "$", { desc = "End of line" })
vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Alternate most recent buffers" })

local function open_cfile()
  local file_name = vim.fn.expand("<cfile>")
  if vim.env.SSH_TTY then
    vim.notify("Cannot open file over SSH.\nThe link is copied via OSC 52.", vim.log.levels.INFO)
    local osc52_seq = string.format("\x1b]52;c;%s\a", vim.base64.encode(file_name))
    vim.api.nvim_ui_send(osc52_seq)
  else
    vim.ui.open(file_name)
  end
end

vim.keymap.set("n", "gx", open_cfile, { desc = "Open the file or link under the cursor" })
vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch, { desc = "Clear search highlight" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "<leader>qq", vim.cmd.qall, { desc = "Quit all" })

-- Cmd-S for save
vim.keymap.set("", "<D-s>", vim.cmd.write, { desc = "Save" })

-- Undo breakpoints
local undo_breakpoint_chars = { ".", ",", "!", "?", ":", ";", "/" }
for _, char in ipairs(undo_breakpoint_chars) do
  vim.keymap.set("i", char, char .. "<C-g>u")
end

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

-- Global LSP mappings: usable without a client attached to the current buffer.
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Send diagnostics to quickfix list" })

vim.keymap.set({ "n", "v" }, "g.", vim.lsp.buf.code_action, { desc = "LSP Code Actions" })
vim.keymap.set({ "n", "v" }, "<leader>lf", function () vim.lsp.buf.format({ async = true }) end, { desc = "LSP Format" })

local utils = require("nvimrc.utils")

local function toggle_conceal()
  local current_conceal = vim.wo.conceallevel
  if current_conceal > 0 then
    vim.w.conceal_value = current_conceal
  end
  utils.toggle("conceallevel", false, { 0, vim.w.conceal_value or 3 })
end

local function toggle_diagnostics()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

local function toggle_inlay_hints()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
end

vim.keymap.set("n", "<leader>uw", function ()
  utils.toggle("wrap")
end, { desc = "Toggle wrap" })
vim.keymap.set("n", "<leader>us", function ()
  utils.toggle("spell")
end, { desc = "Toggle spell" })
vim.keymap.set("n", "<leader>uc", toggle_conceal, { desc = "Toggle conceal" })
vim.keymap.set("n", "<leader>ud", toggle_diagnostics, { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>ui", toggle_inlay_hints, { desc = "Toggle inlay hints" })

-- Terminal mode
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Normal Mode" })
