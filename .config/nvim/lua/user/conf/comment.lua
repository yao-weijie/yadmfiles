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
        ---Operator-pending mapping
        ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        basic = true,
        ---Extra mapping
        ---Includes `gco`, `gcO`, `gcA`
        extra = true,
    },

    pre_hook = nil,
    post_hook = nil,
})
