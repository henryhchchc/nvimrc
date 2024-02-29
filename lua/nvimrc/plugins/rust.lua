local function options()
  local defaultOpts = require("nvimrc.lsp").lsp_default_opts()
  local rustConfig = {
    server = defaultOpts,
    dap = {
      adapter = {
        type = "executable",
        command = "lldb-dap",
        name = "lldb",
      },
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
