return {
    "kylechui/nvim-surround",
    version = "*",
    opts = {
        keymaps = {
            insert = "<C-y>s",
            insert_line = "<C-y>S",
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
