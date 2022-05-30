vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.title = true
vim.opt.clipboard:append("unnamed,unnamedplus")

vim.opt.timeoutlen = 300
vim.opt.updatetime = 100

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

vim.g.mapleader = " "
vim.opt.splitright = true

vim.g.tex_flavor = "latex"

vim.opt.spelllang = { "en_us", "cjk" }

-- Auto switch between relative line number and absolute line number
local toggleCmdGroup = vim.api.nvim_create_augroup("numbertoggle", {})
vim.api.nvim_create_autocmd({
    "BufEnter",
    "FocusGained",
    "InsertLeave",
    "WinEnter",
}, {
    group = toggleCmdGroup,
    callback = function()
        if vim.wo.number then
            local mode = vim.api.nvim_get_mode().mode
            if mode ~= "i" then
                vim.wo.relativenumber = true
            end
        end
    end,
})
vim.api.nvim_create_autocmd({
    "BufLeave",
    "FocusLost",
    "InsertEnter",
    "WinLeave",
}, {
    group = toggleCmdGroup,
    callback = function()
        if vim.wo.number then
            vim.wo.relativenumber = false
        end
    end,
})

local function toggleSpellCheck()
    local currentSpell = vim.opt.spell:get()
    vim.opt.spell = not currentSpell
end

vim.keymap.set("n", "<leader>ts", toggleSpellCheck, { desc = "Toggle Spell Checking" })
