---@type vim.lsp.Config
return {
  cmd = { "kotlin-language-server" },
  filetypes = { "kotlin" },
  root_markers = { "gradlew", "settings.gradle", "setting.gradle.kts", "pom.xml", ".git/" },
  settings = {
    kotlin = { formatting = { formatter = "ktlint" } },
  },
}
