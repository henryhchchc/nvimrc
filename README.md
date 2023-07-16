# My Neovim Configuration

## Usage

Symlink this repository to the Neovim configuration directory.
Let's assume that `pwd` is the directory where you clone this repository.

```bash
mkdir -p ~/.config/nvim
ln -sf "$(pwd)/init.lua" ~/.config/nvim/init.lua
ln -sf "$(pwd)/lua" ~/.config/nvim/lua
```

Start `nvim` and enjoy.
