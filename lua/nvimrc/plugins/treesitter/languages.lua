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
  latex = { "plaintex", "tex" },
  robots_txt = { "robots" },
  ssh_config = { "sshconfig" },
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

return {
  parsers = parsers,
  filetypes = filetypes,
  filetype_aliases = filetype_aliases,
}
