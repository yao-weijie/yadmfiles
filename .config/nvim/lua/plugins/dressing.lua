return {
    "stevearc/dressing.nvim",
    event = { "VeryLazy" },
    version = "*",
    opts = {
        input = {
            prefer_width = 40,
            max_width = { 80, 0.9 },
            min_width = { 20, 0.2 },
            mappings = {
                n = {
                    ["q"] = "Close",
                    ["<CR>"] = "Confirm",
                },
                i = {
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                    ["<C-p>"] = "HistoryPrev",
                    ["<C-n>"] = "HistoryNext",
                    ["<Up>"] = "HistoryPrev",
                    ["<Down>"] = "HistoryNext",
                },
            },
        },
        select = {
            backend = { "telescope", "fzf_lua", "nui" },
            fzf_lua = {
                winopts = {
                    height = 0.5,
                    width = 0.5,
                },
            },
        },
    },
}
