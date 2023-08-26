local function configure()
  local defaultOpts = require("nvimrc.lsp").lsp_default_opts()
  local rustConfig = {
    server = defaultOpts,
    dap = {
      adapter = {
        type = "executable",
        command = "lldb-vscode",
        name = "rt_lldb",
      },
    },
  }
  require("rust-tools").setup(rustConfig)
end

return {
  { "simrat39/rust-tools.nvim", ft = { "rust" }, config = configure },
  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    event = "BufRead Cargo.toml",
  },
}
