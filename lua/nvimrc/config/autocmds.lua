-- Auto switch between relative and absolute line numbers
local number_toggle = vim.api.nvim_create_augroup("number_toggle", {})
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = number_toggle,
  callback = function ()
    if vim.wo.number and vim.api.nvim_get_mode().mode ~= "i" then
      vim.wo.relativenumber = true
    end
  end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = number_toggle,
  callback = function ()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

-- Highlight yanked text
local highlight_yanked = vim.api.nvim_create_augroup("highlight_yanked", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_yanked,
  callback = function ()
    vim.hl.on_yank({ timeout = 200 })
  end,
})

-- Equalize window sizes when terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("resize_splits", {}),
  callback = function ()
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      local win = vim.api.nvim_tabpage_get_win(tab)
      vim.api.nvim_win_call(win, function ()
        vim.cmd("wincmd =")
      end)
    end
  end,
})

local close_window_filetypes = {
  "help",
  "lspinfo",
  "man",
  "notify",
  "qf",
}

local natural_language_filetypes = {
  "gitcommit",
  "markdown",
  "text",
  "tex",
  "norg",
  "org",
}

-- Close transient windows with q and <C-c>
local close_window = vim.api.nvim_create_augroup("close_window", {})
vim.api.nvim_create_autocmd("FileType", {
  group = close_window,
  pattern = close_window_filetypes,
  callback = function (event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", vim.cmd.close, { desc = "Close window", buf = event.buf })
    vim.keymap.set("n", "<C-c>", vim.cmd.close, { desc = "Close window", buf = event.buf })
  end,
})

-- Enable wrap and spell for natural-language filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", {}),
  pattern = natural_language_filetypes,
  callback = function ()
    vim.opt_local.wrap = true
    if vim.bo.modifiable then
      vim.opt_local.spell = true
    end
  end,
})

-- Enable conceal for readonly buffers
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("conceal_readonly", {}),
  callback = function ()
    if vim.bo.readonly then
      vim.opt_local.conceallevel = 3
    end
  end,
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last_loc", {}),
  callback = function (event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.list_contains(exclude, vim.bo[buf].filetype) then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local line_count = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Stop snippet completion when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("stop_snippet", {}),
  callback = function ()
    vim.snippet.stop()
  end,
})
