local function configure()
    local aerial_on_attach = function(bufnr)
        vim.keymap.set("n", "<leader>ta", "<Cmd>AerialToggle!<CR>", { buffer = bufnr, desc = "Toggle Aerial" })
        vim.keymap.set("n", "[a", "<Cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Aerial Go to Previous" })
        vim.keymap.set("n", "]a", "<Cmd>AerialNext<CR>", { buffer = bufnr, desc = "Aerial Go to Next" })
    end

    require("aerial").setup({
        min_width = 20,
        show_guides = true,
        on_attach = aerial_on_attach,
        filter_kind = {
            "File",
            "Module",
            "Package",
            "Namespace",
            "Class",
            "Interface",
            "Struct",
            "Enum",
            "Constructor",
            "Field",
            "Function",
            "Method",
        },
    })
end

return configure
