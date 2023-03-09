return {
    "numToStr/Comment.nvim",
    -- keys = {
    --     { "<leader>c", mode = { "n", "v" } },
    --     { "<leader>C", mode = { "n", "v" } },
    -- },
    opts = {
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
    },
}
