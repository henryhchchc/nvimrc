vim.opt.autowrite = true

vim.opt.clipboard = "unnamedplus"

if vim.env.SSH then
  if vim.env.TMUX then
    vim.g.clipboard = "tmux"
  else
    vim.g.clipboard = "osc52"
  end
end

vim.opt.colorcolumn = "+1"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.concealcursor = "nc"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.formatoptions = "jcroqlnt"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.laststatus = 0
vim.opt.list = true
vim.opt.listchars:append("tab:> ,trail:⋅,nbsp:⋅,multispace:⋅,conceal:?")
vim.opt.mouse = "ar"
vim.opt.number = true
vim.opt.pumblend = 5
vim.opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
  "help",
  "globals",
  "skiprtp",
  "folds",
}
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ I = true, c = true, C = true })
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.spelllang = { "en_us", "cjk" }
vim.opt.spelloptions = { "camel" }
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500
vim.opt.title = true
vim.opt.titlestring = "%t - Neovim"
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 100
vim.opt.virtualedit = "block"
vim.opt.wildmode = "longest:full,full"
vim.opt.winblend = 10
vim.opt.winminwidth = 5
vim.opt.wrap = false

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.fillchars = "fold: "
vim.opt.foldlevel = 255

vim.g.mapleader = " "
vim.g.markdown_recommended_style = 0
vim.g.tex_flavor = "latex"

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable programming language providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.guicursor = {
  "n-v-c-sm:block",
  "i-c-ci-ve:ver25-Cursor/iCursor-blinkwait1000-blinkon100-blinkoff100",
  "r-cr-o:hor20",
}

vim.g.skip_ts_context_commentstring_module = true
