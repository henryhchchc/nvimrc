local M = {}

local lazy_repo = "https://github.com/folke/lazy.nvim.git"

local function is_interactive()
  return #vim.api.nvim_list_uis() > 0
end

local function echo(chunks, history)
  vim.api.nvim_echo(chunks, history or false, {})
end

local function format_failure(output)
  if output == nil or output == "" then
    return "Unknown error"
  end

  return output
end

local function fail_bootstrap(output)
  local message = {
    { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
    { format_failure(output), "WarningMsg" },
  }

  if is_interactive() then
    table.insert(message, { "\nPress any key to exit..." })
  end

  echo(message, true)

  if is_interactive() then
    vim.fn.getchar()
  end

  os.exit(1)
end

local function clone_lazy(lazy_path)
  if vim.fn.executable("git") == 0 then
    fail_bootstrap("git is not available in PATH")
  end

  echo({
    { "Downloading and installing lazy.nvim" },
  }, false)

  if vim.system then
    local result = vim
        .system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazy_repo, lazy_path }, { text = true })
        :wait()
    if result.code ~= 0 then
      fail_bootstrap(result.stderr ~= "" and result.stderr or result.stdout)
    end
    return
  end

  local output = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazy_repo,
    lazy_path,
  })
  if vim.v.shell_error ~= 0 then
    fail_bootstrap(output)
  end
end

function M.ensure_installed(lazy_path)
  if vim.uv.fs_stat(lazy_path) then
    return
  end

  clone_lazy(lazy_path)
end

return M
