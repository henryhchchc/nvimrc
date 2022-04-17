vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.title = true
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
vim.opt.timeoutlen = 300
vim.opt.updatetime = 100
vim.opt.splitright = true
vim.opt.spelllang = { "en_us", "cjk" }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.opt.listchars:append("tab:> ,trail:⋅,nbsp:⋅,multispace:⋅,conceal:?")
vim.opt.grepprg = "rg --vimgrep"

vim.undofile = true

vim.g.mapleader = " "
vim.g.tex_flavor = "latex"

vim.opt.pumblend = 10
vim.opt.winblend = 10
vim.opt.termguicolors = true
vim.opt.showtabline = 2

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
