local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    vim.notify("bufferline not found!")
    return
end

bufferline.setup({
    options = {
        numbers = "ordinal",
        offsets = {
            {
                filetype = "NvimTree",
                text = "NvimTree Explorer",
                text_align = "center",
            },
            {
                filetype = "neo-tree",
                text = "NeoTree Explorer",
                text_align = "center",
            },
        },
        show_close_icon = false,
        separator_style = "thick",
    },
})

-- stylua: ignore start
local go_to_buffer = require("bufferline").go_to_buffer
require("which-key").register({
    ["<leader>1"] = { function() go_to_buffer(1, true) end, "go to buffer 1" },
    ["<leader>2"] = { function() go_to_buffer(2, true) end, "go to buffer 2" },
    ["<leader>3"] = { function() go_to_buffer(3, true) end, "go to buffer 3" },
    ["<leader>4"] = { function() go_to_buffer(4, true) end, "go to buffer 4" },
    ["<leader>5"] = { function() go_to_buffer(5, true) end, "go to buffer 5" },
    ["<leader>6"] = { function() go_to_buffer(6, true) end, "go to buffer 6" },
    ["<leader>7"] = { function() go_to_buffer(7, true) end, "go to buffer 7" },
    ["<leader>8"] = { function() go_to_buffer(8, true) end, "go to buffer 8" },
    ["<leader>9"] = { function() go_to_buffer(9, true) end, "go to buffer 9" },
}, {})
-- stylua: ignore end
