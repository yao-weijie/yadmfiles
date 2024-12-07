return {
    "Saghen/blink.cmp",
    version = "v0.*",
    dependencies = "rafamadriz/friendly-snippets",
    lazy = false,
    opts = {
        keymap = {
            preset = "enter",
        },
        completion = {
            accept = {
                auto_brackets = {
                    enabled = true,
                    -- default_brackets = { "(", ")" },
                    -- override_brackets_for_filetypes = {},
                },
            },
            menu = {
                draw = {
                    treesitter = true,
                },
            },
            documentation = {
                auto_show = true,
            },
        },
        signature = {
            enabled = true,
        },
    },
}
