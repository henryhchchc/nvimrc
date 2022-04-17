return {
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false
                },
                telemetry = { enable = false },
                format = {
                    defaultConfig = {
                        indent_style = "space",
                        indent_size = "4",
                        column_width = 150,
                        quote_style = "double",
                        end_of_line = "lf"
                    }
                }
            },
        },
    },
}
