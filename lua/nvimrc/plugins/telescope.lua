local M = {}

function M.setup()
  require("nvimrc.plugins.telescope.setup").setup()
  for _, key in ipairs(require("nvimrc.plugins.telescope.keys")) do
    vim.keymap.set("n", key[1], key[2], { desc = key.desc })
  end
end

return M
