---@type LazySpec
return {
    "folke/which-key.nvim",
    lazy = true,
    opts = {
        preset = "classic",
        icons = { colors = false }, -- disable mini.icons
        win = {
            padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
        },
        delay = 1000,
        triggers = {
            { "<leader>", mode = "nxso" },
            { "[", mode = "nxso" },
            { "]", mode = "nxso" },
            { "g", mode = "nxso" },
        },
        disable = {
            bf = {},
            ft = { "TelescopePrompt" },
        },
    },
}
