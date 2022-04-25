local M = {}

local function configureComment()
    require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
            line = "gcc",
            block = "gbc",
        },
        opleader = {
            line = "gc",
            block = "gb",
        },
        extra = {
            above = "gcO",
            below = "gco",
            eol = "gcA",
        },
        mappings = {
            basic = true,
            extra = true,
            extended = false,
        },
        pre_hook = nil,
        post_hook = nil,
    })
end

local function configureBlankline()
    vim.opt.list = true
    vim.opt.listchars:append("tab:>>,trail:⋅,nbsp:⋅,multispace:⋅,conceal:?")

    require("indent_blankline").setup({
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
    })
end

local function configureHop()
    local hop = require("hop")
    hop.setup()
    local hintDirection = require("hop.hint").HintDirection

    -- stylua: ignore
    local char1Mappings = {
        { mode = "n", key = "f", desc = "Forward", opt = { direction = hintDirection.AFTER_CURSOR, inclusive_jump = false } },
        { mode = "n", key = "F", desc = "Backward", opt = { direction = hintDirection.BEFORE_CURSOR, inclusive_jump = false } },

        { mode = "", key = "t", desc = "Forward", opt = { direction = hintDirection.AFTER_CURSOR } },
        { mode = "", key = "T", desc = "Backward", opt = { direction = hintDirection.BEFORE_CURSOR } },

        { mode = "o", key = "f", desc = "Forward", opt = { direction = hintDirection.AFTER_CURSOR, inclusive_jump = true } },
        { mode = "o", key = "F", desc = "Backward", opt = { direction = hintDirection.BEFORE_CURSOR, inclusive_jump = true } },
    }

    for _, it in ipairs(char1Mappings) do
        vim.keymap.set(it.mode, it.key, function()
            hop.hint_char1(it.opt)
        end, { desc = "HOP Char 1 " .. it.desc })
    end
end

local function configureAutoPair()
    require("nvim-autopairs").setup({
        check_ts = true,
    })
end

function M.packer(use)
    use({ "numToStr/Comment.nvim", config = configureComment })
    use({ "lukas-reineke/indent-blankline.nvim", config = configureBlankline })
    use({ "phaazon/hop.nvim", config = configureHop })
    use({
        "windwp/nvim-autopairs",
        requires = {
            { "nvim-treesitter/nvim-treesitter" },
        },
        after = { "nvim-treesitter" },
        config = configureAutoPair,
    })
    use({ "RRethy/nvim-align" })
    use({
        "Pocco81/AutoSave.nvim",
        config = function()
            require("autosave").setup({ enabled = false })
        end,
    })
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                css = {
                    RGB      = true,
                    RRGGBB   = true,
                    names    = true,
                    RRGGBBAA = true,
                    rgb_fn   = true,
                    hsl_fn   = true,
                    css      = true,
                    css_fn   = true,
                }
            })
        end,
    })
end

return M
