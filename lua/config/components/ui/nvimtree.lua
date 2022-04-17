local M = {}

local function configure()
    local specialFiles = {
        "build.sbt",

        "build.gradle",
        "build.gradle.kts",
        "pom.xml",

        "CMakeList.txt",
        "init.lua",
        "Cargo.toml",
        "lib.rs",
        "mod.rs",
        "main.rs",

        "Makefile",
        "README.md",
        "readme.md",

        "Dockerfile",
        "Containerfile",

        "package.json",
        "pyproject.toml",
    }

    local nvimTree = require("nvim-tree")

    local attach_callback = function(bufnr)
        local api = require("nvim-tree.api")
        local function desc(key_desc)
            return {
                desc = key_desc,
                buffer = bufnr,
                noremap = true,
                silent = true,
                nowait = true,
            }
        end
        vim.keymap.set("n", "<CR>", api.node.open.edit, desc("Open"))
        vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, desc("Open"))
        vim.keymap.set("n", "<C-v>", api.node.open.vertical, desc("Open in vsplit"))
        vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, desc("Open in place"))
        vim.keymap.set("n", "<Tab>", api.node.open.preview, desc("Preview"))
        vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, desc("Toggle gitignore"))
        vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, desc("Toggle hidden files"))
        vim.keymap.set("n", "R", api.tree.reload, desc("Refresh"))
        vim.keymap.set("n", "a", api.fs.create, desc("Create new file or directory"))
        vim.keymap.set("n", "D", api.fs.trash, desc("Move to trash"))
        vim.keymap.set("n", "rn", api.fs.rename_basename, desc("Rename"))
        vim.keymap.set("n", "dd", api.fs.cut, desc("Cut"))
        vim.keymap.set("n", "yy", api.fs.copy.node, desc("Copy"))
        vim.keymap.set("n", "p", api.fs.paste, desc("Paste"))
        vim.keymap.set("n", "yn", api.fs.copy.filename, desc("Copy name"))
        vim.keymap.set("n", "yp", api.fs.copy.relative_path, desc("Copy relative path"))
        vim.keymap.set("n", "ya", api.fs.copy.absolute_path, desc("Copy absolute path"))
        vim.keymap.set("n", "gx", api.node.run.system, desc("Open with system"))
        vim.keymap.set("n", "q", api.tree.close, desc("Close nvim-tree"))
        vim.keymap.set("n", "zC", api.tree.collapse_all, desc("Collapse all"))
        vim.keymap.set("n", "zA", api.tree.expand_all, desc("Expand all"))
        vim.keymap.set("n", "S", api.tree.search_node, desc("Search"))
        vim.keymap.set("n", "K", api.node.show_info_popup, desc("File info"))
        vim.keymap.set("n", "?", api.tree.toggle_help, desc("Toggle help"))
    end

    nvimTree.setup({
        on_attach = attach_callback,
        sync_root_with_cwd = true,
        update_focused_file = { enable = true },
        update_cwd = true,
        system_open = { cmd = "open" },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = false,
            severity = {
                min = vim.diagnostic.severity.ERROR,
                max = vim.diagnostic.severity.ERROR,
            },
        },
        filters = {
            custom = { "^\\.git$", "^\\.DS_Store$" },
        },
        git = {
            ignore = false,
            show_on_dirs = true,
            show_on_open_dirs = false,
        },
        renderer = {
            root_folder_label = false,
            full_name = true,
            group_empty = true,
            highlight_opened_files = "name",
            icons = {
                symlink_arrow = " -> ",
                glyphs = {
                    git = {
                        unstaged = "•",
                        staged = "+",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "",
                        deleted = "✗",
                        ignored = "",
                    },
                },
            },
            special_files = specialFiles,
            indent_markers = {
                enable = true,
            },
        },
        view = {
            adaptive_size = false,
            preserve_window_proportions = true,
        },
        actions = {
            change_dir = { enable = false },
            file_popup = {
                open_win_config = {
                    border = "single",
                },
            },
        },
        trash = { cmd = "trash" },
    })
end

M.pluginSpec = {
    "kyazdani42/nvim-tree.lua",
    config = configure,
    cmd = { "NvimTreeOpen", "NvimTreeToggle" },
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
    },
}

return M
