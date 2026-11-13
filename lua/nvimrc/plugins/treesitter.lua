local parsers = require("nvimrc.parsers")

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


---@param bufnr integer
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
  require("nvimrc.config.folding").refresh(bufnr)
end

for parser, aliases in pairs(filetype_aliases) do
  vim.treesitter.language.register(parser, aliases)
end

vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("nvimrc_treesitter", { clear = true }),
  callback = function (event) start(event.buf) end,
})

local syncing = false
vim.api.nvim_create_user_command("TSParsersSync", function ()
  if syncing then
    vim.notify("Tree-sitter parser sync is already running", vim.log.levels.INFO)
    return
  end
  syncing = true

  -- Bypass CLI cache cleanup, which races when ~/.cache points to ~/Library/Caches.
  vim.env.TREE_SITTER_LIBDIR = vim.fn.tempname()
  local treesitter = require("nvim-treesitter")
  ---@param err any
  ---@param success boolean?
  local function finished(err, success)
    syncing = false
    if err or success == false then
      vim.notify("Tree-sitter parser sync failed: " .. tostring(err or "see :messages"), vim.log.levels.ERROR)
      return
    end
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      start(bufnr)
    end
    vim.notify("Tree-sitter parsers are up to date", vim.log.levels.INFO)
  end

  treesitter.update(parsers):await(vim.schedule_wrap(function (err, success)
    if err or success == false then
      finished(err, success)
      return
    end
    treesitter.install(parsers):await(vim.schedule_wrap(finished))
  end))
end, { desc = "Update and install configured Tree-sitter parsers" })
