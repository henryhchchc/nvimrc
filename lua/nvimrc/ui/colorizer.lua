local M = {}

local function configureColorizer()
  require("colorizer").setup({
    css = {
      RGB = true,
      RRGGBB = true,
      names = true,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
    },
  })
end

M.pluginSpec = {
  "norcalli/nvim-colorizer.lua",
  config = configureColorizer,
  cmd = {
    "ColorizerAttachToBuffer",
    "ColorizerDetachFromBuffer",
    "ColorizerReloadAllBuffers",
    "ColorizerToggle",
  },
}

return M
