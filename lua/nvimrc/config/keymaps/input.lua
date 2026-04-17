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
