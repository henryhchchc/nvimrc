local M = {}

function M.setup()
  require("neo-tree").setup(require("nvimrc.plugins.neotree.opts"))
  vim.keymap.set("n", "<leader>e", function ()
    require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
  end, { desc = "Explorer NeoTree (root dir)" })
end

return M
