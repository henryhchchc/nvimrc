local function configure()
    require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        ignore_install = { "phpdoc", "swift" },
        highlight = {
            enabled = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
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
                },
            },
        },
    })
    vim.cmd([[
        set foldmethod=expr
        set foldexpr=nvim_treesitter#foldexpr()
        set foldlevel=99
    ]])
end

return configure
