local M = {}

local function configure()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    local sharedMappings = {
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
    }

    telescope.setup({
        pickers = {
            spell_suggest = { theme = "cursor" },
            find_files = {
                find_command = {
                    "fd",
                    "--type",
                    "f",
                    "--strip-cwd-prefix",
                    "--hidden",
                    "--exclude",
                    ".git/",
                    "--exclude",
                    ".git",
                },
            },
            help_tags = {
                mappings = { i = { ["<CR>"] = actions.select_vertical } },
            },
        },
        defaults = {
            sorting_strategy = "ascending",
            layout_strategy = "flex",
            layout_config = {
                prompt_position = "top",
            },
            default_mappings = {
                i = vim.tbl_deep_extend("force", sharedMappings, {}),
                n = vim.tbl_deep_extend("force", sharedMappings, {
                    ["<esc>"] = actions.close,
                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                }),
            },
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--trim",
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("zoxide")
    telescope.load_extension("noice")

    require("telescope._extensions.zoxide.config").setup({ prompt_title = "Zoxide List" })

    telescope.builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>tf", telescope.builtin.find_files, { desc = "Telescope Find Files" })
    vim.keymap.set("n", "<leader>tg", telescope.builtin.live_grep, { desc = "Telescope Live grep" })
    vim.keymap.set("n", "<leader>tb", telescope.builtin.buffers, { desc = "Telescope Find Buffer" })
    vim.keymap.set("n", "<leader>th", telescope.builtin.help_tags, { desc = "Telescope Find Help" })
    vim.keymap.set("n", "<leader>td", telescope.builtin.diagnostics, { desc = "Telescope List Diagnostics" })
    vim.keymap.set("n", "<leader>tm", telescope.builtin.man_pages, { desc = "Telescope Find Man Pages" })

    vim.keymap.set("n", "<leader>gs", telescope.builtin.git_status, { desc = "Telescope Git Status" })

    vim.keymap.set("n", "<leader>cd", telescope.extensions.zoxide.list, { desc = "Telescope Zoxide" })

    vim.keymap.set("n", "z=", telescope.builtin.spell_suggest, { desc = "Telescope Spell Suggestions" })
end

M.pluginSpec = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "jvgrootveld/telescope-zoxide" },
        { "nvim-telescope/telescope-dap.nvim" },
        { "nvim-lua/plenary.nvim" },
    },
    config = configure,
    event = "VeryLazy",
    cmd = "Telescope",
}

return M
