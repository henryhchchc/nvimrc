local M = {}

function M.setup()
  require("catppuccin").setup(require("nvimrc.plugins.catppuccin.opts"))
  vim.cmd.colorscheme("catppuccin")
end

return M
