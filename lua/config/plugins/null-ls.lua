local function configure()
    local nullLs = require("null-ls")

    nullLs.setup({
        log = { enable = false },
        sources = {
            -- nullLs.builtins.completion.spell,
            nullLs.builtins.formatting.prettier,
            nullLs.builtins.hover.dictionary,
        },
    })
end

return configure
