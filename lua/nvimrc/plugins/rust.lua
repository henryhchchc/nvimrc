--- @type LazyPluginSpec[]
return {
  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    config = true,
  },
  {
    "mrcjkb/rustaceanvim",
  },
}
