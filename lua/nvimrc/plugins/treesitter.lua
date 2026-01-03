--- @type TSConfig
local languages = {
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
  "tmux",
  "toml",
  "typst",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
  "zig",
  "zsh",
}

--- @type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function (_self, _opts)
      require("nvim-treesitter").install(languages, {
        max_jobs = 1,
        generate = true,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function ()
          vim.treesitter.start()
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufEnter",
  },
}
