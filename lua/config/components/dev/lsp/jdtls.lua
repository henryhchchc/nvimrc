local M = {}

local function configure()
    local defaultOpts = require("config.components.dev.lsp").makeDefaultOpts()
    local localConfig = vim.g.local_lsp_config.jdtls or {}
    local rootDir
    if localConfig.root_dir then
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
        rootDir = localConfig.root_dir(bufname)
    else
        rootDir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })
    end
    local extraJdtLsConfig = {
        cmd = {
            "jdtls",
            "-configuration",
            vim.fs.normalize("$HOME/.cache/jdtls/config"),
            "-data",
            vim.fs.normalize(string.format("$HOME/.cache/jdtls/project_data/%s/", rootDir)),
            "--jvm-arg=-XX:+UseZGC",
        },
        root_dir = rootDir,
        on_attach = function(client, bufnr)
            defaultOpts.on_attach(client, bufnr)
            require("jdtls").setup_dap({ hotcodereplace = "auto" })
        end,
        init_options = {
            extendedClientCapabilities = {
                progressReportProvider = false,
            },
        },
    }
    local finalConfig =
        vim.tbl_deep_extend("force", defaultOpts, extraJdtLsConfig, localConfig or {}, { root_dir = rootDir })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "java" },
        callback = function() require("jdtls").start_or_attach(finalConfig) end,
    })
    require("jdtls").start_or_attach(finalConfig)
end

M.pluginSpec = { "mfussenegger/nvim-jdtls", ft = { "java" }, config = configure }

return M
