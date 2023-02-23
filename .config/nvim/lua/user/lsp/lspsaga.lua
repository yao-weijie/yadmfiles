local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
    vim.notify("lspsaga not found")
    return
end

saga.setup({
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
})
