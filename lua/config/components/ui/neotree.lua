local M = {}

local keymaps = {
    ["<space>"] = "none",
    ["<leader>rn"] = "rename",
    ["<2-LeftMouse>"] = "open",
    ["<cr>"] = "open",
    ["P"] = { "toggle_preview", config = { use_float = true } },
    ["l"] = "focus_preview",
    ["S"] = "open_split",
    ["v"] = "open_vsplit",
    ["t"] = "open_tabnew",
    ["w"] = "open_with_window_picker",
    ["C"] = "close_node",
    ["z"] = "close_all_nodes",
    ["a"] = {
        "add",
        config = {
            show_path = "relative",
        },
    },
    ["A"] = "add_directory",
    ["D"] = "delete",
    ["yy"] = "copy_to_clipboard",
    ["dd"] = "cut_to_clipboard",
    ["p"] = "paste_from_clipboard",
    ["q"] = "close_window",
    ["R"] = "refresh",
    ["?"] = "show_help",
    ["<"] = "prev_source",
    [">"] = "next_source",
}

local neotreeOpts = {
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    filesystem = {
        follow_current_file = true,
        use_libuv_file_watcher = true,
    },
    window = {
        mappings = keymaps,
    },
    default_component_configs = {
        indent = {
            with_expanders = true,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_empty = "󰜌",
            folder_empty_open = "󰜌",
        },
        git_status = {
            symbols = {
                renamed = "󰁕",
                unstaged = "󰄱",
            },
        },
    },
}

local keymaps = {
    {
        "<leader>e",
        function() require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() }) end,
        desc = "Explorer NeoTree (root dir)",
        remap = true,
    },
}

M.pluginSpec = {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = keymaps,
    opts = neotreeOpts,
    init = function()
        vim.g.neo_tree_remove_legacy_commands = 1
        if vim.fn.argc() == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then require("neo-tree") end
        end
    end,
}

return M
