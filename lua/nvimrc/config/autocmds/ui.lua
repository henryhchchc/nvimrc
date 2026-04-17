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
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Equalize window sizes when terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("resize_splits", {}),
  callback = function ()
    vim.cmd("tabdo wincmd =")
  end,
})
