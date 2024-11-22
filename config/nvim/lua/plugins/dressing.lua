---@type LazySpec
return {
    "stevearc/dressing.nvim",
    event = { "VeryLazy" },
    version = "*",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
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
            backend = { "fzf_lua", "telescope", "nui" },
            fzf_lua = {
                winopts = {
                    height = 0.5,
                    width = 0.5,
                },
            },
        },
    },
}
