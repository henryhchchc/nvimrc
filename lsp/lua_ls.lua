---@type vim.lsp.Config
return {
  settings = { Lua = {} },
  before_init = function (_, config)
    local root = vim.uv.fs_realpath(config.root_dir or "")
    local nvimrc = vim.uv.fs_realpath(vim.fn.stdpath("config"))
    if not root or root ~= nvimrc then return end

    local settings = assert(config.settings).Lua
    settings.workspace = settings.workspace or {}
    settings.workspace.library = vim.api.nvim_get_runtime_file("lua", true)
  end,
}
