vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.laststatus = 0
vim.opt.list = true
vim.opt.listchars:append("tab:> ,trail:⋅,nbsp:⋅,multispace:⋅,conceal:?")
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.spelllang = { "en_us", "cjk" }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen"
vim.opt.tabstop = 2
vim.opt.timeoutlen = 300
vim.opt.title = true
vim.opt.titlestring = "%t - NVIM"
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 100
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = false

vim.g.mapleader = " "
vim.g.tex_flavor = "latex"

vim.opt.termguicolors = true

vim.opt.conceallevel = 3
vim.opt.concealcursor = "nc"

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable programming language providers
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
