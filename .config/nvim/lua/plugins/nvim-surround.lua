return {
    "kylechui/nvim-surround",
    version = "*",
    event = { "BufRead" },
    opts = {
        keymaps = {
            insert = false,
            insert_line = false,
            normal = "ys",
            normal_cur = "yss",
            normal_line = "yS",
            normal_cur_line = "ySS",
            visual = "ys",
            visual_line = "yS",
            delete = "ds",
            change = "cs",
        },
    },
}
