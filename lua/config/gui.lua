if vim.g.neovide then
    -- Workaround of neovide starting up form finder
    if vim.fn.getcwd() == "/" then
        vim.api.nvim_set_current_dir(vim.env.HOME)
    end

    vim.o.guifont = "Liga SFMono Nerd Font:h12"
    vim.g.neovide_refresh_rate = 120
    vim.keymap.set("n", "<leader>tf", function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    end, { desc = "Toggle GUI Full Screen" })
end

if vim.fn.has("gui_vimr") == 1 then
    vim.keymap.set("n", "<leader>tf", "<Cmd>VimRToggleFullscreen<CR>", { desc = "Toggle GUI Full Screen" })
end
