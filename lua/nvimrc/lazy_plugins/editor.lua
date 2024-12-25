--- @type LazyPluginSpec[]
return {
  { "kylechui/nvim-surround", config = true, event = { "BufReadPost", "BufNewFile" } },
}
