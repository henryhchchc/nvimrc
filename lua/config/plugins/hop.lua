local function configure()
    local hop = require("hop")
    hop.setup()
    local hintDirection = require("hop.hint").HintDirection

    -- stylua: ignore
    local char1Mappings = {
        { mode = "n", key = "f", desc = "Forward", opt = { direction = hintDirection.AFTER_CURSOR, inclusive_jump = false } },
        { mode = "n", key = "F", desc = "Backward", opt = { direction = hintDirection.BEFORE_CURSOR, inclusive_jump = false } },

        { mode = "", key = "t", desc = "Forward", opt = { direction = hintDirection.AFTER_CURSOR } },
        { mode = "", key = "T", desc = "Backward", opt = { direction = hintDirection.BEFORE_CURSOR } },

        { mode = "o", key = "f", desc = "Forward", opt = { direction = hintDirection.AFTER_CURSOR, inclusive_jump = true } },
        { mode = "o", key = "F", desc = "Backward", opt = { direction = hintDirection.BEFORE_CURSOR, inclusive_jump = true } },
    }

    for _, it in ipairs(char1Mappings) do
        vim.keymap.set(it.mode, it.key, function()
            hop.hint_char1(it.opt)
        end, { desc = "HOP Char 1 " .. it.desc })
    end
end

return configure
