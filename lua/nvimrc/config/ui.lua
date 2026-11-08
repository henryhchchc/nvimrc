vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("nvimrc_pager", {}),
  pattern = "pager",
  callback = function ()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.colorcolumn = ""
    vim.opt_local.winhighlight = { Normal = "NormalFloat", NormalNC = "NormalFloat" }
    vim.opt_local.winblend = 0
  end,
})

vim.o.cmdheight = 0
require("vim._core.ui2").enable({
  msg = {
    target = "msg",
    targets = { list_cmd = "pager" },
    msg = { height = 0.25, timeout = 4000 },
    pager = { height = 0.5 },
  },
})
