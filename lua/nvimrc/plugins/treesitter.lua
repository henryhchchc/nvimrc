--- Parsers to install and update.
local parsers = {
  "bash",
  "bibtex",
  "c",
  "cmake",
  "comment",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "editorconfig",
  "fish",
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "html",
  "htmldjango",
  "ini",
  "java",
  "javascript",
  "json",
  "json5",
  "just",
  "kotlin",
  "latex",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "nix",
  "perl",
  "python",
  "robots_txt",
  "ruby",
  "rust",
  "ssh_config",
  "starlark",
  "strace",
  "sql",
  "swift",
  "svelte",
  "toml",
  "tsx",
  "typescript",
  "typst",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
  "zig",
  "zsh",
}

--- Parsers that are only ever injected into another language's tree. They are
--- never a filetype, so they must not be used as a FileType pattern.
local injected_only = {
  comment = true,
  markdown_inline = true,
}

--- Parsers whose name differs from the Neovim filetype(s) they serve. These
--- filetypes are used as the FileType pattern in place of the parser name and
--- have to be registered against the parser: vim.treesitter.start() resolves
--- the language from the filetype and would otherwise look for a parser named
--- after the filetype and find none.
local filetype_aliases = {
  bash = { "sh" },
  bibtex = { "bib" },
  git_config = { "gitconfig" },
  git_rebase = { "gitrebase" },
  ini = { "dosini" },
  javascript = { "javascript", "javascriptreact" },
  json = { "json", "jsonc" },
  latex = { "plaintex", "tex" },
  robots_txt = { "robots" },
  ssh_config = { "sshconfig" },
  tsx = { "typescriptreact" },
  vimdoc = { "help" },
}

local filetypes = {}
for _, parser in ipairs(parsers) do
  local aliases = filetype_aliases[parser]
  if aliases then
    vim.list_extend(filetypes, aliases)
  elseif not injected_only[parser] then
    filetypes[#filetypes + 1] = parser
  end
end

local M = {}


local function start(bufnr)
  if not vim.api.nvim_buf_is_loaded(bufnr)
      or not vim.list_contains(filetypes, vim.bo[bufnr].filetype)
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

  for parser, filetypes in pairs(filetype_aliases) do
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
      treesitter.install(parsers, { max_jobs = 1 }):await(vim.schedule_wrap(installed))
    end))
  end)
end

return M
