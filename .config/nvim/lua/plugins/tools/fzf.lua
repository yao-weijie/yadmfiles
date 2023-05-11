return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = { "VeryLazy" },
    enabled = vim.fn.executable("fzf") == 1,
    opts = {
        "default",
        -- preview = {
        --     layout = "horizontal",
        -- },
        previewers = {
            bat = {
                cmd = vim.fn.executable("batcat") == 1 and "batcat" or "bat",
            },
        },
    },
}
