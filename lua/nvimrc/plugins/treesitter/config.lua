local M = {}

local languages = require("nvimrc.plugins.treesitter.languages")

function M.setup()
  local treesitter = require("nvim-treesitter")

  treesitter.setup()
  treesitter.install(languages, {
    generate = true,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = languages,
    callback = function()
      vim.treesitter.start()
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end,
  })
end

return M
