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

return {
  parsers = parsers,
  filetypes = vim.tbl_filter(function (name)
    return not injected_only[name]
  end, parsers),
}
