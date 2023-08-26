local function configureBlankline()
  require("indent_blankline").setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    use_treesitter = true,
    filetype_exclude = {
      "help",
      "alpha",
      "dashboard",
      "NvimTree",
      "Trouble",
      "lazy",
      "notify",
      "toggleterm",
      "lazyterm",
    },
  })
end

--- @type LazyPluginSpec
return {
  "lukas-reineke/indent-blankline.nvim",
  config = configureBlankline,
  event = { "BufReadPost", "BufNewFile" },
}
