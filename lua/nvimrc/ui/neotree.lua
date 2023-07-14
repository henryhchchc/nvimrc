local M = {}

local treeKeymaps = {
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
    ["H"] = "toggle_hidden",
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
    use_popups_for_input = false,
    use_default_mappings = false,
    filesystem = {
        group_empty_dirs = true,
        follow_current_file = true,
        use_libuv_file_watcher = true,
        filtered_items = {
            never_show = {
                ".git",
            },
        },
    },
    window = {
        mappings = treeKeymaps,
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
    source_selector = {
        winbar = false,
        statusline = false,
        show_scrolled_off_parent_node = false,
        sources = {
            { source = "filesystem", display_name = "File System" },
            { source = "buffers", display_name = "Buffers" },
            { source = "git_status", display_name = "Git Status" },
            { source = "document_symbols", display_name = "Document Symbols" },
        },
    },
    document_symbols = {
        kinds = {
            File = { icon = "󰈙", hl = "Tag" },
            Namespace = { icon = "󰌗", hl = "Include" },
            Package = { icon = "󰏖", hl = "Label" },
            Class = { icon = "󰌗", hl = "Include" },
            Property = { icon = "󰆧", hl = "@property" },
            Enum = { icon = "󰒻", hl = "@number" },
            Function = { icon = "󰊕", hl = "Function" },
            String = { icon = "󰀬", hl = "String" },
            Number = { icon = "󰎠", hl = "Number" },
            Array = { icon = "󰅪", hl = "Type" },
            Object = { icon = "󰅩", hl = "Type" },
            Key = { icon = "󰌋", hl = "" },
            Struct = { icon = "󰌗", hl = "Type" },
            Operator = { icon = "󰆕", hl = "Operator" },
            TypeParameter = { icon = "󰊄", hl = "Type" },
            StaticMethod = { icon = "󰠄 ", hl = "Function" },
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
