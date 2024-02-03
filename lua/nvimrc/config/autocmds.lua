local close_window_file_types = {
  "help",
  "lspinfo",
  "Trouble",
  "man",
  "notify",
  "qf",
  "neotest-output",
  "neotest-summary",
  "neotest-output-panel",
}

local narual_lang_ft = {
  "gitcommit",
  "markdown",
  "text",
  "tex",
  "norg",
  "org",
}

-- Auto switch between relative and absolute line numbers
local number_toggle = vim.api.nvim_create_augroup("number_toggle", {})
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = number_toggle,
  callback = function ()
    if vim.wo.number and vim.api.nvim_get_mode().mode ~= "i" then vim.wo.relativenumber = true end
  end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = number_toggle,
  callback = function ()
    if vim.wo.number then vim.wo.relativenumber = false end
  end,
})

-- Highlight yanked text
local highlight_yanked = vim.api.nvim_create_augroup("highlight_yanked", {})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = highlight_yanked,
  callback = function () vim.highlight.on_yank() end,
})

-- Close window with q and <C-c>
local close_window = vim.api.nvim_create_augroup("close_window", {})
vim.api.nvim_create_autocmd("FileType", {
  group = close_window,
  pattern = close_window_file_types,
  callback = function (event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", vim.cmd.close, { desc = "Close window", buffer = event.buf })
    vim.keymap.set("n", "<C-c>", vim.cmd.close, { desc = "Close window", buffer = event.buf })
  end,
})

-- Enable wrap and spell for certain file types
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", {}),
  pattern = narual_lang_ft,
  callback = function ()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Equalize window sizes when terminal is resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = vim.api.nvim_create_augroup("resize_splits", {}),
  callback = function () vim.cmd("tabdo wincmd =") end,
})


local auto_format_group = vim.api.nvim_create_augroup("lsp_auto_format", {})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = auto_format_group,
  ---@diagnostic disable-next-line: unused-local
  callback = function (event)
    if vim.b.autoformat then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

-- Enable conceal for readonly buffers
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("conceal_readonly", {}),
  pattern = "*",
  callback = function ()
    if vim.bo.readonly then
      vim.opt_local.conceallevel = 3
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("restore_cursor", {}),
  callback = function ()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})
