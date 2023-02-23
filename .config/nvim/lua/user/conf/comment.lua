local status_ok, Comment = pcall(require, "Comment")
if not status_ok then
    vim.notify("Comment not found!")
    return
end

Comment.setup({
    padding = true,
    sticky = true,
    ignore = "^$",

    toggler = {
        line = "<leader>cc",
        block = "<leader>CC",
    },
    opleader = {
        line = "<leader>c",
        block = "<leader>C",
    },
    extra = {
        above = "<leader>cO",
        below = "<leader>co",
        eol = "<leader>cA",
    },
    mappings = {
        basic = true,
        extra = true,
    },
    pre_hook = nil,
    post_hook = nil,
})
