require("which-key").register({
    ["<leader>p"] = { "<cmd>call AddPrintLine(0, 0)<CR>", "vim-printer below" },
    ["<leader>P"] = { "<cmd>call AddPrintLine(0, 1)<CR>", "vim-printer above" },
}, { mode = { "n", "v" } })
