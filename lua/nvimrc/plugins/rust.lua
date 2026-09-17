--- @type LazyPluginSpec[]
return {
  { "saecki/crates.nvim", event = "BufRead Cargo.toml", config = true },
  {
    "mrcjkb/rustaceanvim",
    init = function ()
      vim.g.rustaceanvim = function ()
        return { tools = { executor = require("rustaceanvim.executors").toggleterm } }
      end
    end,
  },
}
