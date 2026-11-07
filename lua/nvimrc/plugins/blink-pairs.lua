local options = {
  highlights = {
    cmdline = false,
    groups = {
      "BlinkPairsRed", "BlinkPairsYellow", "BlinkPairsBlue", "BlinkPairsOrange",
      "BlinkPairsGreen", "BlinkPairsPurple", "BlinkPairsCyan",
    },
    matchparen = { enabled = false },
  },
}

local pairs = require("blink.pairs")
require("nvimrc.native").setup("blink.pairs", pairs, options, "Downloading pairing library",
  pairs.download)
