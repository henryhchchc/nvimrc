-- nvim-lspconfig's rust_analyzer config copies settings["rust-analyzer"] into
-- initializationOptions in its before_init, so server settings belong here
-- rather than in init_options, which would be overwritten.
---@type vim.lsp.Config
return {
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
      diagnostics = {
        experimental = {
          enabled = true,
        },
      },
    },
  },
}
