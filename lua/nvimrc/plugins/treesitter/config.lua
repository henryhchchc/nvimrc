local M = {}

local languages = require("nvimrc.plugins.treesitter.languages")

function M.setup()
  local treesitter = require("nvim-treesitter")

  treesitter.setup()

  vim.api.nvim_create_autocmd("FileType", {
    pattern = languages.filetypes,
    callback = function ()
      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end,
  })

  vim.schedule(function ()
    treesitter.install(languages.parsers, { max_jobs = 1 })
  end)
end

return M
