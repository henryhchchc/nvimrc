local function options()
  local lsp_default_opts = require("nvimrc.lsp").lsp_default_opts()
  local executors = require("rustaceanvim.executors")
  ---@type RustaceanConfig
  local rustConfig = {
    server = lsp_default_opts,
    tools = {
      executor = executors.toggleterm,
    },
  }
  return rustConfig
end

return {
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    opts = options,
    config = function (_self, opts) vim.g.rustaceanvim = opts end,
  },
  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls.nvim" },
    opts = {
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    },
    config = true,
    event = "BufRead Cargo.toml",
  },
}
