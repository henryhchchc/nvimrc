local close_window_file_types = {
  "help",
  "lspinfo",
  "man",
  "notify",
  "qf",
  "neotest-output",
  "neotest-summary",
  "neotest-output-panel",
}

local natual_lang_ft = {
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
  pattern = natual_lang_ft,
  callback = function ()
    vim.opt_local.wrap = true
    if vim.bo.modifiable then
      vim.opt_local.spell = true
    end
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
  callback = function (_event)
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

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last_loc", {}),
  callback = function (event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Stop snippet completion when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("stop_snippet", {}),
  callback = vim.snippet.stop,
})


-- Show diagnostics on cursor holds
-- vim.api.nvim_create_autocmd("CursorHold", {
--   group = vim.api.nvim_create_augroup("show_diagnostics", {}),
--   callback = function ()
--     vim.diagnostic.open_float({ scope = "cursor" })
--   end,
-- })
