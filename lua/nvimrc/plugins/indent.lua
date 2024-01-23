--- @type ibl.config
local options = {}

--- @type LazyPluginSpec
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = options,
  event = { "BufReadPost", "BufNewFile" },
}
