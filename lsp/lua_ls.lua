---@type vim.lsp.Config
return {
  settings = { Lua = {} },
  before_init = function (_, config)
    local root = vim.uv.fs_realpath(config.root_dir or "")
    local nvimrc = vim.uv.fs_realpath(vim.fn.stdpath("config"))
    if not root or root ~= nvimrc then return end

    local settings = assert(config.settings)
    ---@cast settings lspconfig.settings.lua_ls
    local lua = assert(settings.Lua)
    lua.workspace = lua.workspace or {}
    local libraries = {}
    local seen = {}
    for _, directory in ipairs(vim.api.nvim_get_runtime_file("lua", true)) do
      local path = vim.uv.fs_realpath(directory)
      if path and not vim.startswith(path, root .. "/") and not seen[path] then
        libraries[#libraries + 1] = path
        seen[path] = true
      end
    end
    lua.workspace.library = libraries
  end,
}
