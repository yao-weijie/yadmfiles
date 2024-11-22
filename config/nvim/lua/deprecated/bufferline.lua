return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
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
        -- cover C-n C-p in vimrc
        { "<C-n>", "<cmd>BufferLineCycleNext<CR>", desc = "next buffer" },
        { "<C-p>", "<cmd>BufferLineCyclePrev<CR>", desc = "prev buffer" },
        { "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "buffer 1" },
        { "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "buffer 2" },
        { "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", desc = "buffer 3" },
        { "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", desc = "buffer 4" },
        { "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", desc = "buffer 5" },
        { "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", desc = "buffer 6" },
        { "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", desc = "buffer 7" },
        { "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", desc = "buffer 8" },
        { "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", desc = "buffer 9" },
    },
}
