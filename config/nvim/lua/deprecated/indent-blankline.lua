return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    version = "*",
    ---@module "ibl"
    ---@type ibl.config
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
