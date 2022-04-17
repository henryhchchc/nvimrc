# My Neovim Configuration

## Usage

Create a symbolic link in the Neovim configuration directory to this repository as follows.
Let's assume that `pwd` is the directory where you clone this repository.

```bash
mkdir -p ~/.config/nvim
ln -sf "$(pwd)/init.lua" ~/.config/nvim/init.lua
ln -sf "$(pwd)/lua" ~/.config/nvim/lua
```

Start `nvim` and enjoy.
