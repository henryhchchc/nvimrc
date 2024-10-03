--- @type LazyPluginSpec[]
return {
  {
    "stevearc/dressing.nvim",
    opts = { input = { enabled = false } },
    event = "VeryLazy",
  },
  {
    "chrisgrieser/nvim-spider",
    event = "WinEnter",
    main = "spider",
    keys = function (_self, _keys)
      return vim.tbl_map(function (key)
        return {
          key,
          function () package.loaded.spider.motion(key) end,
          mode = { "n", "o", "x" },
          desc = "Move sub-word (" .. key .. ")",
        }
      end, { "e", "w", "b" })
    end,
    config = true,
  },
}
