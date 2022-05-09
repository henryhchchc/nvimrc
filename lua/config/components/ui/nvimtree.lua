local M = {}

function M.configure()
    local nvimTree = require("nvim-tree")
    nvimTree.setup({
        update_cwd = true,
        disable_netrw = true,
        hijack_netrw = true,
        open_on_tab = true,
        hijack_unnamed_buffer_when_opening = true,
        diagnostics = { enable = true },
        update_focused_file = { enable = true },
        system_open = { cmd = "open" },
        filters = { custom = { "^\\.git$", "^\\.DS_Store$" } },
        git = { ignore = false },
        view = {
            width = 30,
            height = 30,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
        },
        renderer = {
            icons = {
                git_placement = "after",
            },
        },
        actions = {
            change_dir = {
                enable = true,
                global = false,
            },
            open_file = {
                quit_on_open = false,
                resize_window = true,
                window_picker = {
                    enable = true,
                    chars = "hjkl1234567890",
                    exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                    },
                },
            },
        },
    })

    vim.keymap.set("n", "<leader>e", nvimTree.focus, { desc = "Goto File Explorer" })
    vim.keymap.set("n", "<leader>te", function()
        nvimTree.toggle(false)
    end, { desc = "Toggle File Explorer" })
end

return M
