local M = {}

---@type string[]
local tsLanguages = require("nvimrc.tslanguages")

---@type TSConfig
local treeSitterOptions = {
    ensure_installed = tsLanguages,
    ignore_install = {},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
        },
    },
    indent = {
        enable = true,
    },
    textobjects = {
        enable = true,
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["as"] = "@statement.outer",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["aa"] = "@prarmeter.outer",
                ["ia"] = "@prarmeter.inner",
            },
        },
    },
    playground = { enable = true },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
    },
    autotag = { enable = true },
    rainbow = { enable = true },
    context_commentstring = { enable = true },
}

local function configureTreeSitter()
    require("nvim-treesitter.configs").setup(treeSitterOptions)
    -- FIX: Disable treesitter folding for now
    --      This is a bug in neovim stdlib
    -- vim.opt.foldmethod = "expr"
    -- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    -- vim.opt.foldlevel = 99
end

--- @type LazyPluginSpec[]
M.pluginSpecs = {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            { "JoosepAlviste/nvim-ts-context-commentstring" },
            { "nvim-treesitter/nvim-treesitter-textobjects" },
        },
        build = ":TSUpdate",
        config = configureTreeSitter,
        event = { "BufReadPost", "BufNewFile" },
    },
    { "windwp/nvim-ts-autotag", dependencies = { "nvim-treesitter/nvim-treesitter" }, event = "InsertEnter" },
    {
        "HiPhish/nvim-ts-rainbow2",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = { max_join_length = 1024 },
        event = { "BufReadPost", "BufNewFile" },
    },
}

return M
