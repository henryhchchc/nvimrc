local M = {}

local function configNavic()
    local navic = require("nvim-navic")
    navic.setup({
        highlight = true,
        depth_limit = 5,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            if args.data then
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client.server_capabilities.documentSymbolProvider then
                    local bufnr = args.buf
                    navic.attach(client, bufnr)
                end
            end
        end,
    })
end

local function diff_source()
    -- This is defined by gitsigns
    ---@diagnostic disable-next-line: undefined-field
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    else
        return {}
    end
end

local function lspName()
    local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
    clients = vim.tbl_filter(function(it) return it.name ~= "null-ls" and it.name ~= "copilot" end, clients)
    local lspCount = vim.tbl_count(clients)
    local prefix = " "
    local content = "N/A"
    if lspCount == 0 then
        content = "N/A"
    elseif lspCount == 1 then
        content = clients[1].name
    else
        content = string.format("%s (%d more)", clients[1].name, lspCount - 1)
    end
    return prefix .. content
end

local lualineOptions = {
    options = {
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
    },
    sections = {
        lualine_a = {
            { "mode", icons_enabled = true },
        },
        lualine_b = {
            "branch",
            { "diff", source = diff_source },
            { "diagnostics", sources = { "nvim_diagnostic" } },
        },
        lualine_c = {
            {
                "filename",
                file_status = true,
                path = 0,
                shorting_target = 40,
                symbols = {
                    modified = "•",
                    readonly = " [Read Only]",
                    unnamed = " [No Name]",
                    new = " [New File]",
                },
            },
            { "navic" },
        },
        lualine_x = { "searchcount", "location" },
        lualine_y = {
            "encoding",
            {
                "fileformat",
                icons_enabled = true,
                symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
            },
            "filesize",
            "filetype",
        },
        lualine_z = {
            {
                lspName,
                on_click = function() vim.cmd.LspInfo() end,
            },
            {
                function() return require("copilot_status").status_string() end,
                cnd = function() return require("copilot_status").enabled() end,
            },
        },
    },
    extensions = {
        "man",
        "nvim-dap-ui",
        "neo-tree",
        "quickfix",
        "aerial",
        "lazy",
        "trouble",
        "fugitive",
    },
}

local function configCopilotStatus()
    require("copilot_status").setup({
        icons = {
            idle = " ",
            error = " ",
            offline = " ",
            warning = " ",
            loading = " ",
        },
    })
end

--- @type LazyPluginSpec
M.pluginSpec = {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        {
            "SmiteshP/nvim-navic",
            config = configNavic,
        },
        {
            "jonahgoldwastaken/copilot-status.nvim",
            dependencies = { "zbirenbaum/copilot.lua" },
            event = "BufReadPost",
            config = configCopilotStatus,
        },
    },
    opts = lualineOptions,
    event = "VeryLazy",
}

return M
