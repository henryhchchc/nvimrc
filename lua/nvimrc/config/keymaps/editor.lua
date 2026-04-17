-- Tab pages
vim.keymap.set("n", "]t", vim.cmd.tabnext, { desc = "Switch to the next tabpage." })
vim.keymap.set("n", "[t", vim.cmd.tabprev, { desc = "Switch to the previous tabpage." })
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew, { desc = "Create a new tabpage." })
vim.keymap.set("n", "<leader>tc", vim.cmd.tabclose, { desc = "Close the current tabpage." })

vim.keymap.set("n", "]x", vim.cmd.cnext, { desc = "Go to the next quickfix location." })
vim.keymap.set("n", "[x", vim.cmd.cprev, { desc = "Go to the previous quickfix location." })
vim.keymap.set("n", "<leader>gq", vim.cmd.copen, { desc = "Open Quickfix Window" })
vim.keymap.set("n", "<leader>gl", vim.cmd.lopen, { desc = "Open Loclist Window" })

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
    vim.fn.chansend(vim.v.stderr, osc52_seq)
  else
    vim.ui.open(file_name)
  end
end

vim.keymap.set("n", "gx", open_cfile, { desc = "Open the file or link under the cursor" })
vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch, { desc = "Clear search highlight" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "<leader>qq", vim.cmd.qall, { desc = "Quit all" })
