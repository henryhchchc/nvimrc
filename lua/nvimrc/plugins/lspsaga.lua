local opts = {
  code_action = {
    keys = {
      quit = { "q", "<C-c>", "<esc>" },
    },
  },
  lightbulb = {
    sign = true,
    virtual_text = false,
  },
  ui = {
    code_action = "󰌶",
    kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    border = "none",
  },
  diagnostic = {
    show_code_action = true,
    extend_relatedInformation = true,
    quit_in_show = { "q", "<esc>", "<C-c>" },
  },
}
require("lspsaga").setup(opts)
