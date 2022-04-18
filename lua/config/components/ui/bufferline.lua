local M = {}
function M.configure()
    local nvimTreeOffset = {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        highlight = "Title",
        padding = 1,
    }
    local bufferline = require("bufferline")
    bufferline.setup({
        options = {
            offsets = { nvimTreeOffset },
            close_command = "Bdelete! %d",
            right_mouse_command = "Bdelete! %d",
            left_mouse_command = "buffer %d",
        },
    })
    vim.keymap.set("n", "]b", function()
        bufferline.cycle(1)
    end, { desc = "Go to Next Buffer" })

    vim.keymap.set("n", "[b", function()
        bufferline.cycle(-1)
    end, { desc = "Go to Previous Buffer" })

    vim.keymap.set("n", "<leader>bp", bufferline.pick_buffer, { desc = "Pick Buffer" })

    for i = 1, 9 do
        vim.keymap.set("n", "<leader>b" .. i, function()
            bufferline.go_to_buffer(i)
        end, { desc = "Go to Buffer #" .. i })
    end
end

return M
