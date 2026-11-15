require("nvimrc.plugins.catppuccin")
require("nvimrc.plugins.treesitter")
require("nvimrc.config.lsp")
require("nvimrc.plugins.git")
require("nvimrc.plugins.telescope")
require("nvimrc.plugins.statusline")
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("nvimrc_crates", { clear = true }),
  pattern = "Cargo.toml",
  callback = function ()
    vim.api.nvim_clear_autocmds({ group = "nvimrc_crates" })
    require("crates").setup({})
  end,
})
require("oil").setup()
require("ibl").setup()
require("nvim-surround").setup()
