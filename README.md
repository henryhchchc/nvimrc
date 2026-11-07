# My Neovim Configuration

## Usage

Symlink the repository itself into place as the Neovim config directory.
Run this from the repository root, and make sure `~/.config/nvim` does not already exist as a real directory (move it aside first): `ln -sfn` into an existing directory would create the link _inside_ it rather than replacing it.

```bash
ln -sfn "$(pwd)" ~/.config/nvim
```

Requires Neovim 0.12+, Git, Rust/Cargo (for Blink CMP), a C compiler, `tree-sitter` CLI 0.26.1+, `curl`, and `tar`.
Language servers must be installed separately.

Start `nvim` and confirm package installation.
`vim.pack` installs the revisions in `nvim-pack-lock.json`.
Blink Pairs downloads a prebuilt library for its tagged release; Blink CMP builds its library from source.
Blink jobs run in the background with progress notifications; completion and pairing activate when their libraries are ready.
Initial parser installation also continues asynchronously.
Inspect `:messages` if installation fails, then restart to retry.
Blink Pairs enables automatic pairing in buffers and the command line; rainbow highlighting is limited to buffers because its command-line highlighter can produce redraw errors with UI2.

## Updates

Run `:lua vim.pack.update()`, review the changes, and write the confirmation buffer to apply them.
Restart Neovim afterward.
Blink libraries are prepared before setup; installed Tree-sitter parsers are updated to match the plugin, then missing parsers are installed.
Keep `nvim-pack-lock.json` under version control.
Tree-sitter follows `main`; Blink Pairs follows tagged releases.

To restore an earlier package state, restore that revision of `nvim-pack-lock.json`, restart Neovim, then run:

```vim
:lua vim.pack.update(nil, { offline = true, target = "lockfile" })
```

Review and write the confirmation buffer, then restart again.
If the required revisions are unavailable locally, omit `offline = true` to fetch them.

Existing downloads under `~/.local/share/nvim/lazy` are left in place for rollback; the native manager uses `~/.local/share/nvim/site/pack/core/opt`.
