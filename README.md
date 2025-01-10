# My Neovim Configuration

## Usage

Create a symbolic link in the Neovim configuration directory to this repository as follows.
Let's assume that `pwd` is the directory where you clone this repository.

```bash
mkdir -p ~/.config/nvim
ln -sf "$(pwd)/init.lua" ~/.config/nvim/init.lua
ln -sf "$(pwd)/lua" ~/.config/nvim/lua
ln -sf "$(pwd)/rocks.toml" ~/.config/nvim/rocks.toml
ln -sf "$(pwd)/rocks-treesitter.toml" ~/.config/nvim/rocks-treesitter.toml
```

Install `luarocks` with your system package manager.

Start `nvim` and follow the on-screen instructions.
