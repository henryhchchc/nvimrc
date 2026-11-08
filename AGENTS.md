# Repository Guidelines

## Project Structure & Module Organization

This repository is a Lua-based Neovim configuration.
See [README.md](README.md) for requirements and installation.

- `init.lua` initializes the loader, packages, plugins, and core configuration.
- `lua/nvimrc/config/` contains options, keymaps, autocommands, and diagnostics.
- `lua/nvimrc/pack.lua` declares native `vim.pack` dependencies; `lua/nvimrc/plugins/` configures them.
- `lsp/` provides language-server overrides; `ftplugin/` holds filetype-specific settings.
- `queries/` contains Tree-sitter queries; `nvim-pack-lock.json` records package revisions.

## Development & Package Management

There is no separate build step.
Launch `nvim` with this checkout installed to exercise changes.

`vim.pack` installs revisions from `nvim-pack-lock.json`; keep it under version control and include intentional dependency changes.
Tree-sitter follows `main`; Blink Pairs follows tagged releases.
Blink Pairs downloads a prebuilt library; Blink CMP builds from source with Cargo.
Libraries are prepared asynchronously before plugin setup.
Run `:TSParsersSync` manually to update and install configured parsers, including after Tree-sitter plugin updates.
Parser maintenance never runs at startup.

Native packages live under `~/.local/share/nvim/site/pack/core/opt`.
Keep Blink Pairs command-line rainbow highlighting disabled: it can cause redraw errors with UI2.

When updating dependencies, run `:lua vim.pack.update()`, review the confirmation buffer, and write it to apply changes.
Restart Neovim, validate affected plugins, and include the resulting lockfile changes in the pull request.

## Coding Style & Naming Conventions

Follow `.editorconfig`: two-space indentation, UTF-8, LF endings, final newlines, and no trailing whitespace.
Lua uses double quotes and a 120-character line limit.
Use local variables and descriptive `snake_case` functions.
Match existing plugin filenames and language-server identifiers.

Use the configured LSP formatter; formatting runs on save when supported.
Do not hand-rewrite formatting when a formatter is available.
`.luarc.json` configures LuaLS for LuaJIT and Neovim libraries.
Format Markdown with `rumdl fmt README.md AGENTS.md` before finishing documentation changes.

## Testing Guidelines

No automated test suite or coverage target is configured.
Do not add automated tests.
Validate changes manually in Neovim.
Restart Neovim, inspect `:messages`, and exercise the affected behavior.
Run `:checkhealth` when changing dependencies or investigating setup failures.
For LSP changes, open a representative source file and verify attachment, diagnostics, mappings, and formatting.
For plugin changes, wait for background installation to finish before checking behavior.
Describe these checks in the pull request.

## Commit & Pull Request Guidelines

Recent commits use concise imperative subjects, such as `Consolidate Neovim configuration modules`.
Keep changes focused.
Pull requests should explain the behavior changed, relevant dependencies, and validation performed.
Link related issues and include screenshots when changing visible UI behavior.

## Agent Instructions

Ask before mutational Git commands.
When asked to commit, inspect recent message style and run the commit outside the sandbox for SSH-agent signing.
If committing fails, report the intended message.
