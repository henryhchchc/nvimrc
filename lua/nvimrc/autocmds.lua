local M = {}

local function autoLineNums()
    local toggleCmdGroup = vim.api.nvim_create_augroup("number_toggle", {})
    vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
        group = toggleCmdGroup,
        callback = function()
            if vim.wo.number and vim.api.nvim_get_mode().mode ~= "i" then vim.wo.relativenumber = true end
        end,
    })
    vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
        group = toggleCmdGroup,
        callback = function()
            if vim.wo.number then vim.wo.relativenumber = false end
        end,
    })
end

local function highlightYanked()
    local highlightYankedGrp = vim.api.nvim_create_augroup("highlight_yanked", {})
    vim.api.nvim_create_autocmd({ "TextYankPost" }, {
        group = highlightYankedGrp,
        callback = function() vim.highlight.on_yank() end,
    })
end

function M.configure()
    autoLineNums()
    highlightYanked()
end

return M
