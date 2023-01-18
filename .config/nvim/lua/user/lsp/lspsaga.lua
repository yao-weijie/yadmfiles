local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
    vim.notify("lspsaga not found")
    return
end

saga.setup({
    symbol_in_winbar = {
        enable = true,
    },
    finder_action_keys = {
        split = "<C-x>",
        tabe = "<C-t>",
        vsplit = "<C-v>",
    },
    definition_action_keys = {
        edit = "<CR>",
        split = "<C-x>",
        vsplit = "<C-v>",
        tabe = "<C-t>",
    },
    lightbulb = {
        enable = false,
    },
})
