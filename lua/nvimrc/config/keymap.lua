local utils = require("nvimrc.utils")


-- Tab pages
vim.keymap.set("n", "]t", vim.cmd.tabnext, { desc = "Switch to the next tabpage." })
vim.keymap.set("n", "[t", vim.cmd.tabprev, { desc = "Switch to the previous tabpage." })
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew, { desc = "Create a new tabpage." })
vim.keymap.set("n", "<leader>tc", vim.cmd.tabclose, { desc = "Close the current tabpage." })

vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Send diagnostics to quickfix list" })

vim.keymap.set("n", "]x", vim.cmd.cnext, { desc = "Go to the next quickfix location." })
vim.keymap.set("n", "[x", vim.cmd.cprev, { desc = "Go to the previous quickfix location." })

-- Moving selection
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move Selection Down" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move Selection Up" })

vim.keymap.set("n", "<leader>gq", vim.cmd.copen, { desc = "Open Quickfix Window" })
vim.keymap.set("n", "<leader>gl", vim.cmd.lopen, { desc = "Open Loclist Window" })

vim.keymap.set("n", "H", "^", { desc = "Start of line (non-blank)" })
vim.keymap.set("n", "L", "$", { desc = "End of line" })

vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Alternate most recent buffers" })

vim.keymap.set(
  "n",
  "ge",
  -- function () vim.diagnostic.open_float({ focus = false, scope = "cursor" }) end,
  function () vim.cmd.Lspsaga("show_cursor_diagnostics", "++unfocus") end,
  { desc = "Show diagnostics" }
)

-- Cmd-S for save
vim.keymap.set("", "<D-s>", vim.cmd.write, { desc = "Save" })
-- LSP
-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Actions" })
vim.keymap.set({ "n", "v" }, "g.", function () vim.cmd.Lspsaga("code_action") end, { desc = "LSP Code Actions" })
vim.keymap.set({ "n", "v" }, "<leader>lf", function () vim.lsp.buf.format({ async = true }) end, { desc = "LSP Format" })
vim.keymap.set("n", "<leader>rN", vim.lsp.buf.rename, { desc = "LSP Rename" })


-- Open the file or link under the cursor
local function open_cfile()
  local file_name = vim.fn.expand("<cfile>")
  if vim.env.SSH_TTY then
    vim.notify("Cannot open file over SSH.\nThe link is copied via OSC 52.", vim.log.levels.INFO)
    local osc52_seq = string.format("\x1b]52;c;%s\a", vim.base64.encode(file_name))
    vim.fn.chansend(vim.v.stderr, osc52_seq)
  else
    vim.ui.open(file_name)
  end
end
vim.keymap.set("n", "gx", open_cfile, { desc = "Open the file or link under the cursor" })

-- Undo breakpoints
local undo_breakpoint_chars = { ".", ",", "!", "?", ":", ";", "/" }
for _, char in ipairs(undo_breakpoint_chars) do
  vim.keymap.set("i", char, char .. "<C-g>u")
end

-- Toggles
vim.keymap.set("n", "<leader>uw", function () utils.toggle("wrap") end, { desc = "Toggle wrap" })
vim.keymap.set("n", "<leader>us", function () utils.toggle("spell") end, { desc = "Toggle spell" })
local function toggle_conceal()
  local current_concel = vim.opt.conceallevel:get()
  local concel_value = current_concel > 0 and current_concel or 3
  return function () utils.toggle("conceallevel", false, { 0, concel_value }) end
end
vim.keymap.set("n", "<leader>uc", toggle_conceal(), { desc = "Toggle conceal" })
vim.keymap.set("n", "<leader>ui", function () vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle inlay hints" })
local function toggle_diagnostics()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end
vim.keymap.set("n", "<leader>ud", toggle_diagnostics, { desc = "Toggle diagnostics" })
vim.keymap.set(
  "n",
  "<leader>uh",
  function () vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}), {}) end,
  { desc = "Toggle Inlay hints" }
)

-- Diagnostics with Lspsaga
vim.keymap.set("n", "]d", function () vim.cmd.Lspsaga("diagnostic_jump_next") end, { desc = "Jump to next diagnostic" })
vim.keymap.set("n", "[d", function () vim.cmd.Lspsaga("diagnostic_jump_prev") end,
  { desc = "Jump to previous diagnostic" })

-- Clear search highlight with <esc>
vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch, { desc = "Clear search highlight" })

-- Terminal mode
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Normal Mode" })

-- Better up/down movement in wrapped lines
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set("n", "<leader>qq", vim.cmd.qall, { desc = "Quit all" })

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
