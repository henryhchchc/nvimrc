vim.cmd("packadd packer.nvim")
local packer = require("packer")

local function packerStartup(use)
    use({ "wbthomason/packer.nvim" })
    use({ "nvim-lua/plenary.nvim" })

    require("config.components.treesitter").packer(use)
    require("config.components.dev").packer(use)
    require("config.components.editing").packer(use)

    require("config.components.ui").packer(use)
    require("config.components.vcs").packer(use)
end

packer.startup({
    packerStartup,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end,
        },
    },
})
