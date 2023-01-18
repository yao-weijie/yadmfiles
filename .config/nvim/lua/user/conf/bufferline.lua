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
                text = "Neo-Tree Explorer",
                text_align = "center",
            },
        },
        show_close_icon = false,
        separator_style = "slant",
    },
})

require("which-key").register({
    ["[b"] = { "<cmd>bprevious<CR>", "buffer prev" },
    ["]b"] = { "<cmd>bnext<CR>", "buffer next" },
    ["<leader>1"] = { "<cmd>lua require('bufferline').go_to_buffer(1, true)<cr>", "go to buffer 1" },
    ["<leader>2"] = { "<cmd>lua require('bufferline').go_to_buffer(2, true)<cr>", "go to buffer 2" },
    ["<leader>3"] = { "<cmd>lua require('bufferline').go_to_buffer(3, true)<cr>", "go to buffer 3" },
    ["<leader>4"] = { "<cmd>lua require('bufferline').go_to_buffer(4, true)<cr>", "go to buffer 4" },
    ["<leader>5"] = { "<cmd>lua require('bufferline').go_to_buffer(5, true)<cr>", "go to buffer 5" },
    ["<leader>6"] = { "<cmd>lua require('bufferline').go_to_buffer(6, true)<cr>", "go to buffer 6" },
    ["<leader>7"] = { "<cmd>lua require('bufferline').go_to_buffer(7, true)<cr>", "go to buffer 7" },
    ["<leader>8"] = { "<cmd>lua require('bufferline').go_to_buffer(8, true)<cr>", "go to buffer 8" },
    ["<leader>9"] = { "<cmd>lua require('bufferline').go_to_buffer(9, true)<cr>", "go to buffer 9" },
}, {})
