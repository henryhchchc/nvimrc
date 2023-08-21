local M = {}

function M.configure()
  local utils = require("nvimrc.utils")

  vim.keymap.set({ "n", "v", "o" }, "<C-c>", "<esc>")

  -- Tab pages
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

  -- Open the file or link under the cursor
  local function open_cfile()
    local file_name = vim.fn.shellescape(vim.fn.expand("<cfile>"))
    if os.getenv("SSH_CONNECTION") then
      vim.notify("Cannot open file over SSH", vim.log.levels.ERROR)
    elseif vim.fn.has("mac") == 1 then
      vim.fn.jobstart("open " .. file_name, { detach = true })
    elseif vim.fn.has("unix") == 1 then
      vim.fn.jobstart("xdg-open " .. file_name, { detach = true })
    end
  end
  vim.keymap.set("n", "gx", open_cfile, { desc = "Open the file or link under the cursor" })

  -- Undo breakpoints
  local undo_breakpoint_chars = { ".", ",", "!", "?", ":", ";", "/" }
  for _, char in ipairs(undo_breakpoint_chars) do
    vim.keymap.set("i", char, char .. "<C-g>u")
  end

  -- Toggles
  vim.keymap.set("n", "<leader>uw", function() utils.toggle("wrap") end, { desc = "Toggle wrap" })
  vim.keymap.set("n", "<leader>us", function() utils.toggle("spell") end, { desc = "Toggle spell" })
  local function toggle_conceal()
    local current_concel = vim.opt.conceallevel:get()
    local concel_value = current_concel > 0 and current_concel or 3
    return function() utils.toggle("conceallevel", false, { 0, concel_value }) end
  end
  vim.keymap.set("n", "<leader>uc", toggle_conceal(), { desc = "Toggle conceal" })
  vim.keymap.set("n", "<leader>ui", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle inlay hints" })
  local function toggle_diagnostics()
    if vim.diagnostic.is_disabled(0) then
      vim.disgnostic.enable(0)
    else
      vim.diagnotic.disable(0)
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
end

return M
