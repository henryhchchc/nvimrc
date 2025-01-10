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
Then, install the required Lua modules as follows.

```bash
luarocks --lua-version=5.1 --tree <rocks_path> --server='https://nvim-neorocks.github.io/rocks-binaries/' install rocks.nvim
```

Where `<rocks_path>` is the output of `:lua =vim.g.rocks_nvim.rocks_path` in `nvim`.

Start `nvim` and follow the on-screen instructions.
