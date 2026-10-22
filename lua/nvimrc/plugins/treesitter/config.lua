local M = {}

local languages = require("nvimrc.plugins.treesitter.languages")

local function start(bufnr)
  if not vim.api.nvim_buf_is_loaded(bufnr)
      or not vim.list_contains(languages.filetypes, vim.bo[bufnr].filetype)
      or not vim.treesitter.get_parser(bufnr) then
    return
  end

  vim.treesitter.start(bufnr)
  vim.bo[bufnr].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
  for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
    if vim.wo[win][0].foldexpr ~= "v:lua.vim.lsp.foldexpr()" then
      vim.wo[win][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end
end

function M.setup()
  local treesitter = require("nvim-treesitter")

  for parser, filetypes in pairs(languages.filetype_aliases) do
    vim.treesitter.language.register(parser, filetypes)
  end

  vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("nvimrc_treesitter", { clear = true }),
    callback = function (event) start(event.buf) end,
  })

  vim.schedule(function ()
    treesitter.install(languages.parsers, { max_jobs = 1 }):await(vim.schedule_wrap(function (err)
      if err then
        vim.notify("Tree-sitter installation failed: " .. tostring(err), vim.log.levels.ERROR)
      end
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        start(bufnr)
      end
    end))
  end)
end

return M
