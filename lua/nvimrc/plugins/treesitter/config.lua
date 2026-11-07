local M = {}

local languages = require("nvimrc.plugins.treesitter.languages")

local function start(bufnr)
  if not vim.api.nvim_buf_is_loaded(bufnr)
      or not vim.list_contains(languages.filetypes, vim.bo[bufnr].filetype)
  then
    return
  end

  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or not parser then
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
    local function installed(err, success)
      if err or success == false then
        vim.notify("Tree-sitter installation failed: " .. tostring(err or "see :messages"), vim.log.levels.ERROR)
        return
      end
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        start(bufnr)
      end
    end

    -- Update installed parsers to match the plugin revision before adding missing ones.
    treesitter.update(nil, { max_jobs = 1 }):await(vim.schedule_wrap(function (err, success)
      if err or success == false then
        installed(err, success)
        return
      end
      treesitter.install(languages.parsers, { max_jobs = 1 }):await(vim.schedule_wrap(installed))
    end))
  end)
end

return M
