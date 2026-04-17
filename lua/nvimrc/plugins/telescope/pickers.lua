local M = {}

local function builtin(method)
  return function()
    require("telescope.builtin")[method]()
  end
end

function M.find_files()
  local theme = require("telescope.themes").get_dropdown({
    previewer = false,
    prompt_title = "Search Project Files",
    layout_config = {
      width = 0.75,
      height = 0.8,
    },
  })

  require("telescope.builtin").find_files(theme)
end

M.live_grep = builtin("live_grep")
M.buffers = builtin("buffers")
M.help_tags = builtin("help_tags")
M.diagnostics = builtin("diagnostics")
M.man_pages = builtin("man_pages")
M.document_symbols = builtin("lsp_document_symbols")
M.workspace_symbols = builtin("lsp_workspace_symbols")
M.spell_suggest = builtin("spell_suggest")

return M
