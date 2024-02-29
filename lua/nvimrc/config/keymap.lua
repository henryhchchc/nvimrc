local utils = require("nvimrc.utils")

vim.keymap.set("n", "<leader>l", vim.cmd.Lazy, { desc = "Lazy.nvim" })

-- Tab pages
vim.keymap.set("n", "]t", vim.cmd.tabnext, { desc = "Switch to the next tabpage." })
vim.keymap.set("n", "[t", vim.cmd.tabprev, { desc = "Switch to the previous tabpage." })
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew, { desc = "Create a new tabpage." })
vim.keymap.set("n", "<leader>tc", vim.cmd.tabclose, { desc = "Close the current tabpage." })

vim.keymap.set(
  "n",
  "[d",
  function () vim.cmd.Lspsaga("diagnostic_jump_prev") end,
  { desc = "Go to the previous diagnostics" }
)
vim.keymap.set(
  "n",
  "]d",
  function () vim.cmd.Lspsaga("diagnostic_jump_next") end,
  { desc = "Go to the next diagnostics" }
)
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

vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Alternate most recent buffers" })

-- Cmd-S for save
vim.keymap.set("", "<D-s>", vim.cmd.write, { desc = "Save" })
-- LSP
-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Actions" })
vim.keymap.set({ "n", "v" }, "<leader>ca", function () vim.cmd.Lspsaga("code_action") end, { desc = "LSP Code Actions" })
vim.keymap.set({ "n", "v" }, "<leader>cf", function () vim.lsp.buf.format({ async = true }) end, { desc = "LSP Format" })
vim.keymap.set("n", "<leader>rN", vim.lsp.buf.rename, { desc = "LSP Rename" })
-- vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Range Code Actions" })


-- TODO: Replace it with buildtin base64 implementation on neovim 0.10
local base64 = (function ()
  local lshift = require("bit").lshift
  local rshift = require("bit").rshift
  local band = require("bit").band
  local bor = require("bit").bor

  local M = {}

  ---@format disable
  local base64 = { [0] = "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S",
    "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
    "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "/" }
  ---@format enable

  local mask = 0x3f -- 0b00111111

  function M.enc(s)
    local len = string.len(s)
    local output = {}

    for i = 1, len, 3 do
      local byte1, byte2, byte3 = string.byte(s, i, i + 2)
      local bits = bor(lshift(byte1, 16), lshift(byte2 or 0, 8), byte3 or 0)
      table.insert(output, base64[rshift(bits, 18)])
      table.insert(output, base64[band(rshift(bits, 12), mask)])
      table.insert(output, base64[band(rshift(bits, 6), mask)])
      table.insert(output, base64[band(bits, mask)])
    end

    for i = 0, 1 - ((len - 1) % 3) do
      output[#output - i] = "="
    end

    return table.concat(output)
  end

  return M
end)()

-- Open the file or link under the cursor
local function open_cfile()
  local file_name = vim.fn.expand("<cfile>")
  if os.getenv("SSH_CONNECTION") then
    vim.notify("Cannot open file over SSH.\nThe link is copied via OSC52.", vim.log.levels.INFO)
    local osc52_seq = string.format("\x1b]52;c;%s\a", base64.enc(file_name))
    vim.fn.chansend(vim.v.stderr, osc52_seq)
  elseif vim.fn.has("mac") == 1 then
    vim.fn.jobstart("open " .. vim.fn.shellescape(file_name), { detach = true })
  elseif vim.fn.has("unix") == 1 then
    vim.fn.jobstart("xdg-open " .. vim.fn.shellescape(file_name), { detach = true })
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
  if vim.diagnostic.is_disabled(0) then
    vim.diagnostic.enable(0)
  else
    vim.diagnostic.disable(0)
  end
end
vim.keymap.set("n", "<leader>ud", toggle_diagnostics, { desc = "Toggle diagnostics" })

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

-- Disable the annoying q mappings
vim.keymap.set({ "n", "v", "o" }, "q:", "<Nop>")
vim.keymap.set({ "n", "v", "o" }, "Q", "q", { desc = "Record macro" })
vim.keymap.set({ "n", "v", "o" }, "q", "<Nop>")
