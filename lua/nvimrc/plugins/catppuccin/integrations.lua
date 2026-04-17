--- @type CtpIntegrations
return {
  blink_cmp = true,
  fidget = true,
  gitsigns = true,
  indent_blankline = {
    enabled = true,
    colored_indent_levels = true,
  },
  markdown = true,
  native_lsp = {
    enabled = true,
    virtual_text = {
      errors = { "italic" },
      hints = { "italic" },
      warnings = { "italic" },
      information = { "italic" },
      ok = { "italic" },
    },
    underlines = {
      errors = { "underline" },
      hints = { "underline" },
      warnings = { "underline" },
      information = { "underline" },
      ok = { "underline" },
    },
    inlay_hints = {
      background = true,
    },
  },
  nvim_surround = true,
  neogit = true,
  neotree = true,
  rainbow_delimiters = true,
  semantic_tokens = true,
  telescope = { enabled = true },
  treesitter = true,
  treesitter_context = true,
  which_key = true,
}
