return {
    "glepnir/lspsaga.nvim",
    commit = "4572ea5010a690e0bc5f132c1df27072df0ecdc1",
    keys = {
        { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "show document" },
        { "gh", "<cmd>Lspsaga lsp_finder<CR>", desc = "preview definition" },
        { "gd", "<cmd>Lspsaga peek_definition<CR>", desc = "preview definition" },
        { "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "diagnostics prev" },
        { "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "diagnostics next" },
        { "<C-LeftMouse>", "<cmd>Lspsaga lsp_finder<CR>", desc = "preview definition" },
        { "<leader>O", "<cmd>Lspsaga outline<CR>", desc = "lspsaga outline" },
    },
    opts = {
        symbol_in_winbar = {
            enable = true,
        },
        finder = {
            keys = {
                jump_to = "p", -- 跳到预览框里
                edit = { "o", "<CR>" }, -- 跳到文件定义处
                split = "<C-x>",
                vsplit = "<C-v>",
                tabe = "<C-t>",
                quit = { "q" },
                close_in_preview = "<Esc>",
            },
        },
        definition = {
            edit = "<CR>",
            split = "<C-x>",
            vsplit = "<C-v>",
            tabe = "<C-t>",
            quit = "q",
            close = "<Esc>",
        },
        -- 调用链
        callhierarchy = {
            show_detail = false,
            keys = {
                edit = "<CR>",
                split = "<C-x>",
                vsplit = "<C-v>",
                tabe = "<C-t>",
                jump = "<C-p>",
                quit = "q",
                expand_collapse = "o",
            },
        },
        lightbulb = {
            enable = false,
        },
        ui = {
            title = vim.fn.has("nvim-0.9") == 1,
            border = "single",
        },
    },
}
