local M = {}

local function configure()
    local lspkind = require("lspkind")
    local lspKindOptions = require("config.components.dev.cmp.lspkind").options
    local cmp = require("cmp")

    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    cmp.setup({
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = lspkind.cmp_format(lspKindOptions),
        },
        snippet = {
            expand = function(args)
                local luasnip = require("luasnip")
                luasnip.lsp_expand(args.body)
            end,
        },
        experimental = {
            ghost_text = { hl_group = "CmpGhostText" },
        },
        preselect = cmp.PreselectMode.None,
        mapping = require("config.components.dev.cmp.cmpkeymap"),
        sources = {
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "luasnip" },
            { name = "crates" },
        },
    })

    cmp.setup.cmdline("/", {
        sources = {
            { name = "buffer" },
        },
    })

    cmp.setup.cmdline(":", {
        sources = {
            { name = "cmdline" },
            { name = "path" },
            { name = "cmdline_history" },
            { name = "fuzzy_path", option = { fd_timeout_msec = 1500 } },
        },
    })
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.pluginSpec = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "onsails/lspkind-nvim" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        {
            "L3MON4D3/LuaSnip",
            opts = { delete_check_events = "TextChanged" },
            dependencies = {
                {
                    "rafamadriz/friendly-snippets",
                    config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
                },
            },
        },
        { "dmitmel/cmp-cmdline-history" },
        {
            "tzachar/cmp-fuzzy-path",
            dependencies = { { "tzachar/fuzzy.nvim" } },
        },
    },
    config = configure,
    event = { "InsertEnter", "CmdlineEnter" },
}

return M
