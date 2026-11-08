vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = "main" },
  { src = "https://github.com/saghen/blink.lib" },
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin", version = "main" },
  { src = "https://github.com/xzbdmw/colorful-menu.nvim" },
  { src = "https://github.com/saecki/crates.nvim", version = vim.version.range("*") },
  { src = "https://github.com/lewis6991/gitsigns.nvim", version = vim.version.range("*") },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim", version = vim.version.range("*") },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("*") },
  { src = "https://github.com/MunifTanjim/nui.nvim", version = vim.version.range("*") },
  { src = "https://github.com/neovim/nvim-lspconfig", version = vim.version.range("*") },
  { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("*") },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/stevearc/oil.nvim", version = vim.version.range("*") },
  { src = "https://github.com/nvim-lua/plenary.nvim", version = vim.version.range("*") },
  { src = "https://github.com/b0o/schemastore.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim", version = vim.version.range("*") },
  { src = "https://github.com/saghen/blink.pairs", version = vim.version.range("*") },
})

vim.api.nvim_create_user_command("PackSync", function ()
  local inactive = vim.iter(vim.pack.get())
      :filter(function (plugin) return not plugin.active end)
      :map(function (plugin) return plugin.spec.name end)
      :totable()

  if #inactive > 0 then
    table.sort(inactive)
    local choice = vim.fn.confirm("Remove unused packages?\n" .. table.concat(inactive, "\n"), "&Yes\n&No", 2)
    if choice ~= 1 then
      return
    end
    vim.pack.del(inactive)
  end

  vim.pack.update()
end, { desc = "Remove unused packages and review updates; restart after editing pack.lua first" })
