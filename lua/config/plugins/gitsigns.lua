local function configure()
    local gs = require("gitsigns")
    gs.setup({
        on_attach = function(bufnr)
            vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Git Stage Hunk" })
            vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Git Reset Hunk" })
            vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Git Stage Buffer" })
            vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Git Undo Stage Hunk" })
            vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Git Reset Buffer" })
            vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Git Preview Hunk" })
            vim.keymap.set("n", "<leader>hb", function()
                gs.blame_line({ full = true })
            end, { buffer = bufnr, desc = "Git Blame Line" })
            vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Git Toggle Current Line Blame" })
            vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Git Diffthis" })
            vim.keymap.set("n", "<leader>td", gs.toggle_deleted, { buffer = bufnr, desc = "Git Toggle Deleted" })
        end,
    })
end

return configure
