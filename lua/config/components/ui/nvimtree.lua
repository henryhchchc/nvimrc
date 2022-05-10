local M = {}

function M.configure()
    local nvimTree = require("nvim-tree")

    vim.g.nvim_tree_group_empty = 1
    vim.g.nvim_tree_create_in_closed_folder = 1
    vim.g.nvim_tree_icons = {
        git = {
            unstaged  = "",
            staged    = "",
            unmerged  = "",
            renamed   = "➜",
            untracked = "",
            deleted   = "",
            ignored   = ""
        },
    }

    nvimTree.setup({
        update_cwd = true,
        disable_netrw = true,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = true,
        diagnostics = { enable = true },
        update_focused_file = { enable = true },
        system_open = { cmd = "open" },
        filters = { custom = { "^\\.git$", "^\\.DS_Store$" } },
        git = { ignore = false },
        renderer = {
            icons = {
                git_placement = "after",
            },
        },
    })

    vim.keymap.set("n", "<leader>e", nvimTree.focus, { desc = "Goto File Explorer" })
    vim.keymap.set("n", "<leader>te", function()
        nvimTree.toggle(false)
    end, { desc = "Toggle File Explorer" })
end

return M
