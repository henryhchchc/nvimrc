local M = {}
function M.configure()
    require("nvim-gps").setup()
    local gps = require("nvim-gps")

    local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
            return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
            }
        end
    end

    require("lualine").setup({
        options = {
            theme = "nordfox",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            globalstatus = true,
        },
        sections = {
            lualine_a = {
                {
                    "mode",
                    icons_enabled = true,
                },
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
                        modified = " ●",
                        readonly = " [R]",
                        unnamed = "[No Name]",
                    },
                },
                {
                    gps.get_location,
                    cond = gps.is_available,
                },
            },
            lualine_x = {
                {
                    "lsp_progress",
                    colors = { use = true },
                },
            },
            lualine_y = {
                "encoding",
                {
                    "fileformat",
                    icons_enabled = true,
                    symbols = {
                        unix = "LF",
                        dos = "CRLF",
                        mac = "CR",
                    },
                },
                "filesize",
                "filetype",
            },
            lualine_z = { "location" },
        },
        extensions = { "nvim-tree", "toggleterm", "symbols-outline" },
    })
end

return M
