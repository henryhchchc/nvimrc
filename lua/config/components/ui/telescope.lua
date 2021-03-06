local M = {}

function M.configure()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
        pickers = {
            lsp_code_actions = { theme = "cursor" },
            lsp_range_code_actions = { theme = "cursor" },
            spell_suggest = { theme = "cursor" },
            find_files = {
                find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--exclude", ".git/" },
            },
        },
        defaults = {
            mappings = {
                i = {
                    ["<esc>"] = actions.close,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({}),
            },
        },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("notify")
    telescope.load_extension("ui-select")
    telescope.load_extension("dap")
    telescope.load_extension("zoxide")

    require("telescope._extensions.zoxide.config").setup({
        prompt_title = "Zoxide List",
    })

    telescope.builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", telescope.builtin.find_files, { desc = "Telescope Find Files" })
    vim.keymap.set("n", "<leader>fg", telescope.builtin.live_grep, { desc = "Telescope Live grep" })
    vim.keymap.set("n", "<leader>fb", telescope.builtin.buffers, { desc = "Telescope Find Buffer" })
    vim.keymap.set("n", "<leader>fh", telescope.builtin.help_tags, { desc = "Telescope Find Help" })
    vim.keymap.set("n", "<leader>fd", telescope.builtin.diagnostics, { desc = "Telescope List Diagnostics" })

    vim.keymap.set("n", "<leader>cd", telescope.extensions.zoxide.list, { desc = "Telescope Zoxide" })

    vim.keymap.set("n", "<leader>dt", telescope.extensions.dap.commands, { desc = "Telescope DAP Commands" })

    vim.keymap.set("n", "z=", telescope.builtin.spell_suggest, { desc = "Telescope Spell Suggestions" })
end

return M
