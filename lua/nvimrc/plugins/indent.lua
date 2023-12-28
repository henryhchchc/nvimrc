--- @type ibl.config.full
local options = {}

--- @type LazyPluginSpec
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = options,
  event = { "BufReadPost", "BufNewFile" },
}
