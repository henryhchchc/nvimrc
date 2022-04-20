local M = {}

local function configureGitSigns()
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
            vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Git Diffthis" })
        end,
    })
end

local function configureNeogit()
    local neogit = require("neogit")
    neogit.setup({
        kind = "vsplit",
    })
    vim.keymap.set("n", "<leader>ng", neogit.open, { desc = "Open Neogit" })
end

function M.packer(use)
    use({
        "TimUntersberger/neogit",
        requires = "nvim-lua/plenary.nvim",
        config = configureNeogit,
    })

    use({
        "lewis6991/gitsigns.nvim",
        config = configureGitSigns,
    })
end

return M
