return function ()
  local settings = {
    texlab = {
      build = {
        executable = "latexmk",
        -- Set `$pdf_mode` in latexmkrc to enable PDF output.
        args = { "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = true,
      },
      chktex = {
        onEdit = false,
        onOpenAndSave = true,
      },
      diagnosticsDelay = 100,
      formatterLineLength = 0,
    },
  }
  if vim.fn.executable("displayline") == 1 then
    settings.texlab.build.forwardSearchAfter = true
    -- Use [Skim](https://skim-app.sourceforge.io) on macOS for forward search.
    settings.texlab.forwardSearch = {
      executable = "displayline",
      args = { "-b", "-g", "%l", "%p", "%f" },
    }
  end

  return settings
end
