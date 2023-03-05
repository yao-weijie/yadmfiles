return {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    lazy = false,
    opts = {
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
    },
    keys = {
        { "<leader>1", "<cmd>lua require('bufferline').go_to_buffer(1, true)<CR>", desc = "buffer 1" },
        { "<leader>2", "<cmd>lua require('bufferline').go_to_buffer(2, true)<CR>", desc = "buffer 2" },
        { "<leader>3", "<cmd>lua require('bufferline').go_to_buffer(3, true)<CR>", desc = "buffer 3" },
        { "<leader>4", "<cmd>lua require('bufferline').go_to_buffer(4, true)<CR>", desc = "buffer 4" },
        { "<leader>5", "<cmd>lua require('bufferline').go_to_buffer(5, true)<CR>", desc = "buffer 5" },
        { "<leader>6", "<cmd>lua require('bufferline').go_to_buffer(6, true)<CR>", desc = "buffer 6" },
        { "<leader>7", "<cmd>lua require('bufferline').go_to_buffer(7, true)<CR>", desc = "buffer 7" },
        { "<leader>8", "<cmd>lua require('bufferline').go_to_buffer(8, true)<CR>", desc = "buffer 8" },
        { "<leader>9", "<cmd>lua require('bufferline').go_to_buffer(9, true)<CR>", desc = "buffer 9" },
    },
}
