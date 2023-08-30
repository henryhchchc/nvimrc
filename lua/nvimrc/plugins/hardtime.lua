--- @type LazyPluginSpec
return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  opts = {
    restriction_mode = "hint",
    disable_mouse = false,
    disabled_filetypes = {
      "help",
      "neo-tree",
      "NeogitStatus",
      "terminal",
      "Trouble",
      "qf",
      "Outline",
      "neotest-summary",
      "neotest-output-panel",
      "sagafinder",
      "sagarename",
      "sagacallhierarchy",
      "sagaoutline",
      "saga_codeaction",
      "sagadiagnostic",
    },
  },
}
