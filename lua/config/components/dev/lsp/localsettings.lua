local M = {}

local function tryReadFile(path)
    local file = io.open(path, "r")
    if file ~= nil then
        local content = file:read("*a")
        file:close()
        return content
    end
    return nil
end

function M.loadProjectLocalConfig()
    local pwd = vim.fn.getcwd()
    local lspConfigFile = pwd .. "/.nvim/lsp.lua"
    local configScript = tryReadFile(lspConfigFile)
    if not configScript then return {} end

    local configFunc, err = loadstring(configScript)
    if not configFunc then
        vim.notify("Project LSP config error: " .. err, vim.log.levels.ERROR, { title = "LSP Config" })
        return {}
    end

    local succ, result = pcall(configFunc)
    if not succ then
        vim.notify("Error when executing .nvim/lsp.lua", vim.log.levels.ERROR, { title = "LSP Config" })
    elseif type(result) ~= "table" then
        vim.notify("Project LSP config should return a table.", vim.log.levels.ERROR, { title = "LSP Config" })
    else
        vim.notify("Project LSP config loaded.", vim.log.levels.INFO, { title = "LSP Config" })
        return result
    end
    return {}
end

return M
