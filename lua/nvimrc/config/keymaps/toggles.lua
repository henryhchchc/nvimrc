local utils = require("nvimrc.utils")

local function toggle_conceal()
  local current_conceal = vim.opt.conceallevel:get()
  local conceal_value = current_conceal > 0 and current_conceal or 3
  return function()
    utils.toggle("conceallevel", false, { 0, conceal_value })
  end
end

local function toggle_diagnostics()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

local function toggle_inlay_hints()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
end

vim.keymap.set("n", "<leader>uw", function()
  utils.toggle("wrap")
end, { desc = "Toggle wrap" })
vim.keymap.set("n", "<leader>us", function()
  utils.toggle("spell")
end, { desc = "Toggle spell" })
vim.keymap.set("n", "<leader>uc", toggle_conceal(), { desc = "Toggle conceal" })
vim.keymap.set("n", "<leader>ud", toggle_diagnostics, { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>ui", toggle_inlay_hints, { desc = "Toggle inlay hints" })
