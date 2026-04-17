local close_window_filetypes = {
  "help",
  "lspinfo",
  "man",
  "notify",
  "qf",
  "neotest-output",
  "neotest-summary",
  "neotest-output-panel",
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
    vim.keymap.set("n", "q", vim.cmd.close, { desc = "Close window", buffer = event.buf })
    vim.keymap.set("n", "<C-c>", vim.cmd.close, { desc = "Close window", buffer = event.buf })
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
