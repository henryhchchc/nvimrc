local pairs = require("blink.pairs")
local ok, err = pairs.download():pwait(60000)
if not ok then
  error(err)
end
pairs.setup({
  mappings = { enabled = true },
  highlights = {
    cmdline = false,
    groups = {
      "BlinkPairsRed", "BlinkPairsYellow", "BlinkPairsBlue", "BlinkPairsOrange",
      "BlinkPairsGreen", "BlinkPairsPurple", "BlinkPairsCyan",
    },
    matchparen = { enabled = false },
  },
})
