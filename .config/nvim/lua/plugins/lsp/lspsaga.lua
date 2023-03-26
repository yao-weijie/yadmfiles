return {
    "glepnir/lspsaga.nvim",
    commit = "36542527c165dc5bf4f26376c0886a7d735596dc", -- Mar 22, 2023
    event = { "BufRead" },
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
        },
        -- 调用链
        callhierarchy = {
            show_detail = false,
            keys = {
                edit = "<CR>",
                split = "<C-x>",
                vsplit = "<C-v>",
                tabe = "<C-t>",
                jump = "o",
                quit = "q",
                expand_collapse = "<Space>",
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
