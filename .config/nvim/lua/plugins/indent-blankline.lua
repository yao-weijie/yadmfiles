return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    version = "*",
    opts = {
        indent = {
            tab_char = "→",
        },
        exclude = {
            filetypes = {
                "dashboard",
            },
        },
    },
}
