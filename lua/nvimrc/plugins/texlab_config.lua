--- @type LazyPluginSpec
return {
  "f3fora/nvim-texlabconfig",
  tag = "v0.1.0",
  config = function () require("texlabconfig").setup() end,
  ft = { "tex", "bib" },
  cmd = { "TexlabInverseSearch" },
  -- Skim config:
  -- Command: nvim
  -- Args: --headless -c "TexlabInverseSearch '%file' %line"
}
