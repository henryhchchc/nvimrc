local M = {}
function M.configure()
    local nvimTreeOffset = {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        highlight = "Title",
    }
    local bufferline = require("bufferline")
    local bufDelete = require("bufdelete")
    bufferline.setup({
        options = {
            offsets = { nvimTreeOffset },
            close_command = function(bufnr)
                bufDelete.bufdelete(bufnr, true)
            end,
            right_mouse_command = "vertical sbuffer %d",
            left_mouse_command = "buffer %d",
            separator_style = "thick",
        },
    })
    vim.keymap.set("n", "]b", function()
        bufferline.cycle(1)
    end, { desc = "Go to Next Buffer" })

    vim.keymap.set("n", "[b", function()
        bufferline.cycle(-1)
    end, { desc = "Go to Previous Buffer" })

    vim.keymap.set("n", "<leader>bb", bufferline.pick_buffer, { desc = "Pick Buffer" })

    for i = 1, 9 do
        vim.keymap.set("n", "<leader>b" .. i, function()
            bufferline.go_to_buffer(i)
        end, { desc = "Go to Buffer #" .. i })
    end
end

return M
