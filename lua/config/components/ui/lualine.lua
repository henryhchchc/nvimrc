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

    local fn_af = require('lualine.components.filename'):extend()
    function fn_af:update_status()
        local data = self.super.update_status(self)
        if self.options.file_status then
            local grp = vim.api.nvim_create_augroup("lsp_auto_format", { clear = false })
            local cmd = vim.api.nvim_get_autocmds({
                group = grp,
            })
            local bufnr = vim.api.nvim_get_current_buf()
            local afEnabled = vim.tbl_filter(function(c) return c.buffer == bufnr end, cmd)[1]
            if afEnabled then
                data = data .. self.options.symbols.auto_format
            end
        end
        return data
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
                    fn_af,
                    file_status = true,
                    path = 0,
                    shorting_target = 40,
                    symbols = {
                        modified = " ●",
                        readonly = " ",
                        unnamed = " [New File]",
                        auto_format = " "
                    },
                },
                {
                    gps.get_location,
                    cond = gps.is_available,
                },
            },
            lualine_x = {},
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
