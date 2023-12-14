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
                "lspinfo",
                "packer",
                "checkhealth",
                "help",
                "man",
                "gitcommit",
                "TelescopePrompt",
                "TelescopeResults",
                "dashboard",
            },
        },
    },
}
