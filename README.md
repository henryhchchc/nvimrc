# My Neovim Configuration

## Requirements

Neovim 0.12+, Git, Rust/Cargo, a C compiler, `tree-sitter` CLI 0.26.1+, `curl`, and `tar`.
Install language servers separately.

## Installation

Symlink the repository itself into place as the Neovim config directory.
Run this from the repository root, and make sure `~/.config/nvim` does not already exist as a real directory (move it aside first): `ln -sfn` into an existing directory would create the link _inside_ it rather than replacing it.

```bash
ln -sfn "$(pwd)" ~/.config/nvim
```

Start `nvim` and confirm package installation.
Completion and pairing libraries install in the background with progress notifications.
These features become available as installation finishes.
Inspect `:messages` if installation fails, then restart to retry.
Run `:checkhealth` to diagnose missing dependencies.

Run `:TSParsersSync` to update and install the parser list in `lua/nvimrc/plugins/treesitter.lua`.
Run it after updating the Tree-sitter plugin too; parser maintenance never runs at startup.
