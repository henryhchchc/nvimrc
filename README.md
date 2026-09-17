# My Neovim Configuration

## Usage

Symlink the repository itself into place as the Neovim config directory.
Run this from the repository root, and make sure `~/.config/nvim` does not already exist as a real directory (move it aside first): `ln -sfn` into an existing directory would create the link *inside* it rather than replacing it.

```bash
ln -sfn "$(pwd)" ~/.config/nvim
```

Start `nvim` and follow the on-screen instructions.
