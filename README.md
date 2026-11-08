# My Neovim Configuration

## Requirements

Neovim 0.12+, Git, a C compiler, `tree-sitter` CLI 0.26.1+, `curl`, and `tar`.
Install language servers separately.

## Installation

Symlink the repository itself into place as the Neovim config directory.
Run this from the repository root, and make sure `~/.config/nvim` does not already exist as a real directory (move it aside first): `ln -sfn` into an existing directory would create the link _inside_ it rather than replacing it.

```bash
ln -sfn "$(pwd)" ~/.config/nvim
```

Start `nvim` and confirm package installation.
Inspect `:messages` if installation fails, then restart to retry.
Run `:checkhealth` to diagnose missing dependencies.

Run `:TSParsersSync` to update and install the parser list in `lua/nvimrc/plugins/treesitter.lua`.
Run it after updating the Tree-sitter plugin too; parser maintenance never runs at startup.

## Completion

Native completion suggests LSP results automatically in buffers with a completion-capable language server.
Buffer-word completion is manual: use Ctrl-X Ctrl-N, or Ctrl-Space when no completion-capable server is attached.
Use Ctrl-Space to request completion, Ctrl-J/Ctrl-K to navigate, Enter to accept, and Ctrl-C to dismiss.
Tab/Shift-Tab jump through snippet placeholders or navigate completion results.
Use Ctrl-X Ctrl-F for file paths and Ctrl-S for LSP signature help.
Command and search completion also open automatically; Ctrl-J/Ctrl-K navigate results.
